defmodule MockForum.Web.Helper.ImageHelpers do
  @moduledoc """
  handels all the image url translations based on S3
  """

  use Phoenix.HTML

  alias MockForum.Avatar

  def profile_icon(%{avatar: avatar} = user) do
      img_tag Avatar.url({avatar, user})
  end
end
