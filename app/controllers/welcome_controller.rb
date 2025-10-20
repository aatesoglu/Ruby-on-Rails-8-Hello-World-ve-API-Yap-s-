class WelcomeController < ApplicationController
  def index
    # Tarayıcıyı sadece development ortamında ve ilk kez açılışta aç
    if Rails.env.development? && !session[:browser_opened]
      system("xdg-open http://localhost:3000") # Linux
      # Windows için:
      # system("start http://localhost:3000")
      # macOS için:
      # system("open http://localhost:3000")

      session[:browser_opened] = true
    end
  end
end
