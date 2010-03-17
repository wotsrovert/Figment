# (c) Copyright 2010 Trevor Stow. All Rights Reserved.

class Notifier < ActionMailer::Base
    include ActionView

    def forgot_password( _user )
        recipients  "#{_user.email}"
        from        "no-reply@figmentproject.org"
        subject     "BoastDrive.com: Password Reset "
        sent_on     Time.now

        body(
            :user => _user,
            :url  => reset_password_url( _user.anonymous_login_code, :host => ( 'figmentproject.org' ) )
        )
    end

    def request_to_play( _recipients, _sender, _subject, _message, _sent_at = Time.now )
        recipients      _recipients
        from            'no-reply@figmentproject.org'
        subject         _subject
        sent_on         _sent_at

        body(
            :sender  => _sender,
            :message => _message
        )
        headers(
            'reply_to' => _sender.email
        ) 
    end
end