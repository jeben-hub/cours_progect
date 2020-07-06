class ApplicationMailer < ActionMailer::Base
  default from: 'from@example.com'
  default host: 'majestic-grand-canyon-79796.herokuapp.com'
  layout 'mailer'
end
