require 'webmock'
include WebMock::API

WebMock.enable!

def stub_iterable_request(method, path, response_body, status = 200)
  stub_request(method, /api.iterable.com\/api\/#{path}/)
    .to_return(status: status, body: response_body.to_json, headers: { 'Content-Type' => 'application/json' })
end

stub_iterable_request(:post, 'events/track', { success: true })
stub_iterable_request(:post, 'email/target', { success: true })
stub_iterable_request(:post, 'users/update', { success: true })