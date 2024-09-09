class ProxiesController < ApplicationController
  before_action :set_proxy, only: %i[ show edit update destroy ]

  # GET /proxies or /proxies.json
  def index
    # @proxies = Proxy.all
    url = URI.parse(params[:url])
    response = Net::HTTP.get_response(url)

    if response.is_a?(Net::HTTPSuccess)
      html = response.body
      base_url = "#{url.scheme}://#{url.host}"

      # Rewrite relative URLs to absolute ones
      html.gsub!(/src=["'](\/[^"']*)["']/, "src=\"#{base_url}\\1\"")
      html.gsub!(/href=["'](\/[^"']*)["']/, "href=\"#{base_url}\\1\"")

      html.gsub!(/<a\s(.*?)href="/, '<a \1 target="_top" href="/newspapers?url=')
      html.gsub!(/<a\s(.*?)href='/, "<a \1 target='_top' href='/newspapers?url=")
      
      render html: html.html_safe
    else
      render plain: "Failed to load content", status: :bad_request
    end
  end

  # GET /proxies/1 or /proxies/1.json
  def show
  end

  # GET /proxies/new
  def new
    @proxy = Proxy.new
  end

  # GET /proxies/1/edit
  def edit
  end

  # POST /proxies or /proxies.json
  def create
    @proxy = Proxy.new(proxy_params)

    respond_to do |format|
      if @proxy.save
        format.html { redirect_to proxy_url(@proxy), notice: "Proxy was successfully created." }
        format.json { render :show, status: :created, location: @proxy }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @proxy.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /proxies/1 or /proxies/1.json
  def update
    respond_to do |format|
      if @proxy.update(proxy_params)
        format.html { redirect_to proxy_url(@proxy), notice: "Proxy was successfully updated." }
        format.json { render :show, status: :ok, location: @proxy }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @proxy.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /proxies/1 or /proxies/1.json
  def destroy
    @proxy.destroy

    respond_to do |format|
      format.html { redirect_to proxies_url, notice: "Proxy was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_proxy
      @proxy = Proxy.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def proxy_params
      params.require(:proxy).permit(:url)
    end
end
