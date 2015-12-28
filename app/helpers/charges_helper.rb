module ChargesHelper

 def refund
    current_user.subscribed=false
    re = Stripe::Refund.create(
     charge: current_user.charge_id
      )
 end

end
