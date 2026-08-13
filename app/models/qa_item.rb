class QaItem
  CATEGORIES = {
    "all"         => "すべて",
    "disease"     => "乳がんについて",
    "screening"   => "検診について",
    "mammography" => "マンモグラフィ",
    "ultrasound"  => "超音波",
    "palpation"   => "視触診・セルフチェック",
    "other"       => "その他"
  }.freeze

  DEFAULT_CATEGORY = "all"
  SOURCE_PATH = Rails.root.join("config", "qa.yml")

  attr_reader :id, :category, :question, :body, :updated_on, :sources

  def initialize(attrs)
    @id         = attrs["id"]
    @category   = attrs["category"]
    @question   = attrs["question"]
    @body       = attrs["body"]
    @updated_on = attrs["updated_on"]
    @sources    = Array(attrs["sources"])
  end

  def category_label
    CATEGORIES[category]
  end

  class << self
    def all
      return load_items if Rails.env.development?
      @all ||= load_items
    end

    def where(category:)
      return all if category == DEFAULT_CATEGORY
      all.select { |item| item.category == category }
    end

    def valid_category?(value)
      CATEGORIES.key?(value)
    end

    def find(id)
      all.find { |item| item.id == id }
    end

    private

    def load_items
      YAML.load_file(SOURCE_PATH).map { |attrs| new(attrs) }
    end
  end
end