# (c) Copyright 2010 Trevor Stow. All Rights Reserved.

class Notifier < ActionMailer::Base
    include ActionView

    def forgot_password( _user )
        recipients  "#{_user.email}"
        from        "no-reply@figmentproject.org"
        subject     "Figment Password Reset "
        sent_on     Time.now

        body(
            :user => _user,
            :url  => reset_password_url( _user.anonymous_login_code, :host => ( 'figmentproject.org' ) )
        )
    end

    def welcome_message_to( _recipients )
        recipients      _recipients
        from            'kevin@figmentproject.org'
        subject         "Welcome to the Figment Project!"
        sent_on         Time.now

        headers(
            'reply_to' => 'kevin@figmentproject.org'
        ) 
    end
    
    'no-reply@figmentproject.org'

end