require 'test_helper'

class ScrapeResultsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @scrape_result = scrape_results(:one)
  end

  test "should get index" do
    get scrape_results_url
    assert_response :success
  end

  test "should get new" do
    get new_scrape_result_url
    assert_response :success
  end

  test "should create scrape_result" do
    assert_difference('ScrapeResult.count') do
      post scrape_results_url, params: { scrape_result: { input: @scrape_result.input, results: @scrape_result.results } }
    end

    assert_redirected_to scrape_result_url(ScrapeResult.last)
  end

  test "should show scrape_result" do
    get scrape_result_url(@scrape_result)
    assert_response :success
  end

  test "should get edit" do
    get edit_scrape_result_url(@scrape_result)
    assert_response :success
  end

  test "should update scrape_result" do
    patch scrape_result_url(@scrape_result), params: { scrape_result: { input: @scrape_result.input, results: @scrape_result.results } }
    assert_redirected_to scrape_result_url(@scrape_result)
  end

  test "should destroy scrape_result" do
    assert_difference('ScrapeResult.count', -1) do
      delete scrape_result_url(@scrape_result)
    end

    assert_redirected_to scrape_results_url
  end
end
