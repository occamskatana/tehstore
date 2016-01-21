class ChargesController < ApplicationController


	def create
		customer = Stripe::Customer.create(
			email: current_user.email,
			card: params[:stripeToken]
			)

		charge = Stripe::Charge.create(
			customer: current_user.id,
			amount: 50,
			description: "store item bought",
			currency: 'usd'
			)

		flash[:notice] = "Thanks for the chips #{current_user.first_name}"

		redirect_to root_path

	rescue Stripe::CardError =>  e 
		flash.now[:alert] = e.message
		redirect_to new_charge_path
	end

	def new
		@stripe_btn_data = {
			key: "#{Rails.configuration.stripe[:publishable_key]}",
			description: "#{current_user.first_name}",
			amount: 50
		}
	end
end