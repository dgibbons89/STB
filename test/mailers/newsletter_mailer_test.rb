require 'test_helper'

class NewsletterMailerTest < ActionMailer::TestCase
  test "thanks" do
    mail = NewsletterMailer.thanks
    assert_equal "Thanks", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
