shared_examples 'healthy response' do
  it 'responds with HTTP 200' do
    expect(http_status).to eq(200)
  end

  it "responds with '{ healthy: true }'" do
    expect(json_body).to eq('healthy' => true)
  end
end

shared_examples 'error response' do |failed_checks:|
  it 'responds with HTTP 500' do
    expect(http_status).to eq(500)
  end

  it "responds with '{ healthy: false }'" do
    expect(json_body).to eq(
      'healthy' => false,
      'failed_checks' => failed_checks
    )
  end
end
