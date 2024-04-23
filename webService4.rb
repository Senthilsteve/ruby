class WebhookService
  def initialize(product)
    @product = product
  end

  def notify_all
    endpoints.each do |endpoint|
      send_notification(endpoint)
    end
  end

  private

  def endpoints
    # Replace with your actual logic for fetching endpoints
    ['http://example.com/webhook', 'http://another-example.com/webhook']
  end

  def send_notification(endpoint)
    HTTParty.post(endpoint, 
      body: @product.to_json, 
      headers: { 'Authorization' => "Token #{Rails.application.secrets.webhook_secret}" }
    )
  end