require 'amount.rb'

class ChargesController < ApplicationController


  def create
  @amount=Amount.new
  # Creates a Stripe Customer object, for associating
  # with the charge
  customer = Stripe::Customer.create(
    email: current_user.email,
    card: params[:stripeToken]
  )


  charge = Stripe::Charge.create(
    customer: customer.id,
    amount: @amount.default,
    description: "BigMoney Membership - #{current_user.email}",
    currency: 'usd'
  )

  if charge
     current_user.subscribed=true
     current_user.strip_id=customer
     current_user.charge_id=charge.id
     current_user.save!(:validate => false)
  end


  flash[:notice] = "Thanks for all the money, #{current_user.email}! Feel free to pay me again."
  redirect_to wikis_path # or wherever

  # Stripe will send back CardErrors, with friendly messages
  # when something goes wrong.
  # This `rescue block` catches and displays those errors.
  rescue Stripe::CardError => e
   flash[:error] = e.message
   redirect_to new_charge_path

  end


  def new
    @amount=Amount.new
    @stripe_btn_data = {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      description: "BigMoney Membership - #{current_user.name}",
      amount: @amount.default
    }
  end


  def status_changing
    if current_user.subscribed==false
      current_user.subscribed=true
      current_user.save!(:validate => false)
      redirect_to wikis_path
    else
      current_user.subscribed=false
      current_user.save!(:validate => false)
      redirect_to wikis_path
    end

  end



end
