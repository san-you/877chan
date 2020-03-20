class SearchResult
  include ActiveModel::Model
  attr_accessor :type, :content, :object
  
  TYPE_BOARD = "スレッド".freeze
  TYPE_COMMENT = "レス".freeze

  def initialize(object)
    if object.instance_of?(Board)
      @type = TYPE_BOARD
      @content = object.title
    end

    if object.instance_of?(Comment)
      @type = TYPE_COMMENT
      @content = object.content
    end

    @object = object
  end

  def self.make_result(query)
    boards = make_board_result(query)
    comments = make_comment_result(query)
    result = []
    result.push(boards).push(comments).flatten!
    return result
  end

  private
    def self.make_board_result query
      boards = Board.where("title LIKE ?", "%" + query + "%")
      result = []
      boards.each do |board|
        result.push(SearchResult.new(board))
      end
      return result
    end

    def self.make_comment_result query
      comments = Comment.where("content LIKE ?", "%" + query + "%")
      result = []
      comments.each do |comment|
        result.push(SearchResult.new(comment))
      end
      return result
    end
end
