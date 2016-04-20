require 'test_helper'

class CoursesTest < ActionDispatch::IntegrationTest
  setup do
    @headers = { 'HTTP_ACCEPT' => 'application/json' }

    @school = School.create(traits(:lonestar))
    @department = Department.create(traits(:math_department, school: @school))
    @algebra = Course.create(traits(:algebra, department: @department))
  end

  test 'can view all courses' do
    get '/api/courses', nil, @headers

    assert get_json_response[:data].size == 1
  end

  test 'can view single course' do
    get "/api/courses/#{@algebra.id}", nil, @headers

    refute get_json_response[:data].empty?
  end

  test 'can search for courses' do
    request_body = { data: { term: 'Alg' }}
    post '/api/courses/search', request_body, @headers

    refute get_json_response[:data].empty?
  end

  test 'can limit search by department' do
    english = Department.create(traits(:english_department, school: @school))
    Course.create(traits(:algebra, department: english))

    request_body = { data: { term: 'Alg', department_id: english.id }}
    post '/api/courses/search', request_body, @headers

    assert_equal 1, get_json_response[:data].size
  end
end