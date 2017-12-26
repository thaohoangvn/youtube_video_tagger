defmodule Mivid.AnnotationView do
  use Mivid.Web, :view

  def render("annotation.json", %{annotation: ann}) do
    %{
      id: ann.id,
      body: ann.body,
      at: ann.at,
      user: render_one(ann.user, Mivid.UserView, "user.json")
    }
  end
end
