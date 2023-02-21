class ParticipationMailer < ApplicationMailer
  default from: 'diot.lionel2@gmail.com'

  def confirmation_email(participation)
    #on récupère l'instance user pour ensuite pouvoir la passer à la view en @user
    @user = participation.user 
    @event = participation.event
    #on définit une variable @url qu'on utilisera dans la view d’e-mail
    @url = 'https://www.thehackingproject.org/fr'

    # c'est cet appel à mail() qui permet d'envoyer l’e-mail en définissant destinataire et sujet.
    mail(to: @user.email, subject: "Confirmation de participation à #{@event.title}") 
  end
end
