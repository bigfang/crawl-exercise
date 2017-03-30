use Amnesia

defdatabase MafwDB do
  deftable Article, [:url, :content], type: :bag do
    @type t :: %Article{url: String.t, content: String.t}

    def add(url, content) do
      %Article{url: url, content: content}
      |> Article.write!()
    end

    def add(url) do
      %Article{url: url, content: nil}
      |> Article.write!()
    end

    def find(url) do
      Article.read!(url)
      |> Enum.at(0)
    end
  end
end
