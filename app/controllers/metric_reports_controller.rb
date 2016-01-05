class MetricReportsController < ApplicationController
  before_action :set_metric_report, only: [:show, :edit, :update, :destroy]

  # GET /metric_reports
  # GET /metric_reports.json
  def index
    @metric_reports = MetricReport.all
  end

  # GET /metric_reports/1
  # GET /metric_reports/1.json
  def show
  end

  # GET /metric_reports/new
  def new
    @metric_report = MetricReport.new
  end

  # GET /metric_reports/1/edit
  def edit
  end

  # POST /metric_reports
  # POST /metric_reports.json
  def create
    @metric_report = MetricReport.new(metric_report_params)

    respond_to do |format|
      if @metric_report.save
        format.html { redirect_to @metric_report, notice: 'Metric report was successfully created.' }
        format.json { render :show, status: :created, location: @metric_report }
      else
        format.html { render :new }
        format.json { render json: @metric_report.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /metric_reports/1
  # PATCH/PUT /metric_reports/1.json
  def update
    respond_to do |format|
      if @metric_report.update(metric_report_params)
        format.html { redirect_to @metric_report, notice: 'Metric report was successfully updated.' }
        format.json { render :show, status: :ok, location: @metric_report }
      else
        format.html { render :edit }
        format.json { render json: @metric_report.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /metric_reports/1
  # DELETE /metric_reports/1.json
  def destroy
    @metric_report.destroy
    respond_to do |format|
      format.html { redirect_to metric_reports_url, notice: 'Metric report was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_metric_report
      @metric_report = MetricReport.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def metric_report_params
      params.require(:metric_report).permit(:name, :period, :period_type, :value)
    end
end
