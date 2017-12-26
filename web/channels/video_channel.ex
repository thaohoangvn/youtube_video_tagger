defmodule Mivid.VideoChannel do
  use Mivid.Web, :channel

  def join("videos:" <> video_id, params, socket) do
    last_seen_id = params["last_seen_id"] || 0
    video_id = String.to_integer(video_id)

    video = Repo.get!(Mivid.Video, video_id)
    annotations = Repo.all(
      from a in assoc(video, :annotations),
      where: a.id > ^last_seen_id,
      order_by: [asc: a.at, asc: a.id],
      limit: 200,
      preload: [:user]
    )
    resp = %{annotations: Phoenix.View.render_many(annotations, Mivid.AnnotationView, "annotation.json")}
    {:ok, resp, assign(socket, :video_id, video_id)}
  end

  def handle_in(event, params, socket) do
    user = Repo.get(Mivid.User, socket.assigns.user_id)
    handle_in(event, params, user, socket)
  end

  def handle_in("new_annotation", params, user, socket) do
    changeset =
      user
      |> build_assoc(:annotations, video_id: socket.assigns.video_id)
      |> Mivid.Annotation.changeset(params)

    case Repo.insert(changeset) do
      {:ok, annotation} ->
        broadcast_annotation(socket, annotation)
        Task.start_link(fn -> compute_additional_info(annotation, socket) end)
        {:reply, :ok, socket}
      {:error, changeset} ->
        {:reply, {:error, %{errors: changeset}}, socket}
    end
  end

  defp compute_additional_info(ann, socket) do
    for result <- Mivid.InfoSys.compute(ann.body, limit: 1, timeout: 10_000) do
      attrs = %{url: result.url, body: result.text, at: ann.at}
      info_changeset = 
        Repo.get_by!(Mivid.User, username: result.backend)
        |> build_assoc(:annotations, video_id: ann.video_id)
        |> Mivid.Annotation.changeset(attrs)
      case Repo.insert(info_changeset) do
        {:ok, info_ann} ->
          broadcast_annotation(socket, info_ann)
        {:error, _changeset} ->
          :ignore
      end
      
    end
  end

  defp broadcast_annotation(socket, annotation) do
    annotation = Repo.preload(annotation, :user)
    rendered_ann = Phoenix.View.render(Mivid.AnnotationView, "annotation.json", %{annotation: annotation})
    broadcast! socket, "new_annotation", rendered_ann
  end
end
