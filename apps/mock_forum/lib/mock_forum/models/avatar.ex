    defmodule MockForum.Avatar do
        @moduledoc false
      use Arc.Definition
      use Arc.Ecto.Definition

      @acl :public_read
      @versions [:original]
      @extension_whitelist ~w(.jpg .jpeg .png)
      # Whitelist file extensions:
      def validate({file, _}) do
          file_extention = file.file_name |> Path.extname |> String.downcase
          Enum.member?(@extension_whitelist, file_extention)
      end

      def transform(:original, _) do
        {:convert, "-strip -thumbnail 75x75^ -gravity center -extent 75x75 -format png", :png}
      end
      # Override the persisted filenames:
      def filename(_version, {_file, _scope}), do: "icon"

      # Override the storage directory:
      def storage_dir(_version, {_file, scope}) do
        "assets/#{scope.id}"
      end

      # Provide a default URL if there hasn't been a file uploaded
      def default_url(_version, scope) do
        email_hash =
            :md5
            |> :crypto.hash(scope.email)
            |> Base.encode16(case: :lower)
        "https://www.gravatar.com/avatar/#{email_hash}?s=75"
      end
    end
