# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class User < ApplicationRecord
    has_many :enrollments,
        primary_key: :id,
        foreign_key: :student_id,
        class_name: :Enrollment

    has_many :enrolled_courses,
        through: :enrollments,
        source: :course
    
    has_many :instructors,
        primary_key: :id,
        foreign_key: :instructor_id,
        class_name: :Course

end
