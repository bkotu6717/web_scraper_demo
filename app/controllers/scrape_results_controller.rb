class ScrapeResultsController < ApplicationController
  before_action :set_scrape_result, only: [:show, :edit, :update, :destroy]

  # GET /scrape_results
  # GET /scrape_results.json
  def index
    @scrape_result = ScrapeResult.new
    @scrape_results = ScrapeResult.paginate(page: params[:page], per_page: 1).order('id DESC')
  end

  # GET /scrape_results/1
  # GET /scrape_results/1.json
  def show
  end

  # GET /scrape_results/new
  def new
    @scrape_result = ScrapeResult.new
  end


  # POST /scrape_results
  # POST /scrape_results.json
  def create
    scraped_data = {}
    url_regex = /^(?:https?:\/\/)?([a-z0-9+.-]+\.[a-z]{2,})(?:\/|\?|'|"|:|&|\s|,|`|#|~|}|$)/i
    web_site = scrape_result_params[:web_site].match(url_regex).captures[0] rescue nil
    @scrape_result = nil
    if web_site.present?
      begin
        scraped_data = WebScrape.new(web_site)
      rescue StandardError => e
        scraped_data = {error: e.message}
      end
      if scraped_data[:error].nil?
        @scrape_result = ScrapeResult.find_by(web_site: web_site)
        if @scrape_result.present?
           @scrape_result.update_attributes(results: scraped_data)
          @scrape_result = ScrapeResult.find_by(web_site: web_site)
        else
          @scrape_result = ScrapeResult.new(web_site: web_site, results: scraped_data)
        end
      else
        @scrape_result = ScrapeResult.new
        @scrape_result.errors.add(:base, scraped_data[:error])
      end
    else
      @scrape_result = ScrapeResult.new(web_site: web_site, results: scraped_data)
      @scrape_result.errors.add(:base, 'Invalid Website URL.')
    end
    respond_to do |format|
      if @scrape_result.errors.none? && @scrape_result.save
        format.html { redirect_to @scrape_result, notice: 'Website was successfully scraped.' }
        format.json { render :show, status: :created, location: @scrape_result }
      else
        flash[:notice] =  @scrape_result.errors[:base].first
        format.html { redirect_to root_path }
        format.json { render json: @scrape_result.errors, status: :unprocessable_entity }
      end
    end
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_scrape_result
      @scrape_result = ScrapeResult.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def scrape_result_params
      params.require(:scrape_result).permit(:web_site, :results)
    end
end
