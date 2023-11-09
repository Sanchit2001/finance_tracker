class StocksController < ApplicationController
    
    def search
        if params[:stock].present?
            @stock = Stock.new_lookup(params[:stock])
            if @stock
                logger.debug @stock
                respond_to do |format|
                    format.turbo_stream do
                        render turbo_stream: turbo_stream.update(
                        "results",
                        partial: "users/result"
                    )
                    end 
                end
            else 
                flash[:alert] = "Please enter a valid symbol"
                respond_to do |format|
                    format.turbo_stream do
                        render turbo_stream: turbo_stream.update(
                        "results",
                        partial: "users/result"
                    )
                    end 
                end
            end
        else
            flash[:alert] = "Please enter a symbol to search"
            respond_to do |format|          
                format.turbo_stream do  
                    render turbo_stream: turbo_stream.update(
                    "results",
                    partial: "users/result"
                )
                end 
            end
        end
    end
end