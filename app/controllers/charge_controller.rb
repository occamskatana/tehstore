class ChargeController < ApplicationController

	before_filter :authorize_user
	skip_before_action :verify_authenticity_token

	def create
		@item = Item.find(params[:item_id])
		
		if @item
			customer = Stripe::Customer.create(
				email: current_user.email,
				card: params[:stripeToken]
				)

			charge = Stripe::Charge.create(
				customer: customer.id,
				amount: @item.sale_price * 100,
				description: "store item bought",
				currency: 'usd'
				)

			flash[:notice] = "Thanks for the chips #{current_user.first_name}"
		else
			flash[:notice] = "Stop doing that bitch!"
		end

		redirect_to root_path

	rescue Stripe::CardError =>  e 
		flash.now[:alert] = e.message
		redirect_to new_charge_path
	end

	def new
		@stripe_btn_data = {
			key: "#{ Rails.configuration.stripe[:publishable_key] }",
			description: "#{current_user.first_name}",
			amount: amount
		}
	end

	private

	def authorize_user
		unless current_user.present?
			flash[:error] = "You must be signed in to access this"
			redirect_to root_path
		end
	end

end