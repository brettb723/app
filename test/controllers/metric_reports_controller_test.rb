require 'test_helper'

class MetricReportsControllerTest < ActionController::TestCase
  setup do
    @metric_report = metric_reports(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:metric_reports)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create metric_report" do
    assert_difference('MetricReport.count') do
      post :create, metric_report: { name: @metric_report.name, period: @metric_report.period, period_type: @metric_report.period_type, value: @metric_report.value }
    end

    assert_redirected_to metric_report_path(assigns(:metric_report))
  end

  test "should show metric_report" do
    get :show, id: @metric_report
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @metric_report
    assert_response :success
  end

  test "should update metric_report" do
    patch :update, id: @metric_report, metric_report: { name: @metric_report.name, period: @metric_report.period, period_type: @metric_report.period_type, value: @metric_report.value }
    assert_redirected_to metric_report_path(assigns(:metric_report))
  end

  test "should destroy metric_report" do
    assert_difference('MetricReport.count', -1) do
      delete :destroy, id: @metric_report
    end

    assert_redirected_to metric_reports_path
  end
end
