require 'sqlite3'
require 'singleton'
require 'byebug'

class QuestionsDatabase < SQLite3::Database
    include Singleton

    def initialize
        # debugger
        super('questions.db')
        self.type_translation = true
        self.results_as_hash = true
    end
end

class Questions
    attr_accessor :id, :title, :body, :author_id

    def self.all
        data = QuestionsDatabase.instance.execute('SELECT * FROM questions')
        # debugger
        data.map do |info| 
            # debugger
            Questions.new(info)
        end
    end

    def self.find_by_id(id)
        question = QuestionsDatabase.instance.execute(<<-SQL, id)
        SELECT
          *
        FROM
          questions
        WHERE
          id = ?
      SQL
        debugger
        Questions.new(question.first)
    end

    def self.find_by_title(title)
        titles = QuestionsDatabase.instance.execute(<<-SQL, title)
        SELECT
            *
        FROM
            questions
        WHERE
            title = ?
      SQL
        return nil unless titles.length > 0

        Questions.new(titles.first) # play is stored in an array!
    end

    def initialize(options)
        # debugger
        @id = options['id']
        @title = options['title']
        @body = options['body']
        @author_id = options['author_id']
    end
end

class Users
    attr_accessor :id, :fname, :lname

    def self.find_by_id(id)
        user = QuestionsDatabase.instance.execute(<<-SQL, id)
        SELECT
          *
        FROM
          users
        WHERE
          id = ?
      SQL
        Users.new(user.first)
    end

    def initialize(options)
        @id = options['id']
        @fname = options['fname']
        @lname = options['lname']
    end

end

class QuestionFollows
    attr_accessor :id, :questions_id, :users_id

    def self.find_by_id(id)
        question_follows = QuestionsDatabase.instance.execute(<<-SQL, id)
        SELECT
          *
        FROM
            question_follows
        WHERE
          id = ?
      SQL
        QuestionFollows.new(question_follows.first)
    end

    def initialize(options)
        @id = options['id']
        @questions_id = options['questions_id']
        @users_id = options['users_id']
    end

end

class Replies
    attr_accessor :id, :body, :question_id, :parent_id, :users

    def self.find_by_id(id)
        question_follows = QuestionsDatabase.instance.execute(<<-SQL, id)
        SELECT
          *
        FROM
            question_follows
        WHERE
          id = ?
      SQL
        QuestionFollows.new(question_follows.first)
    end

    def initialize(options)
        @id = options['id']
        @questions_id = options['questions_id']
        @users_id = options['users_id']
    end

end