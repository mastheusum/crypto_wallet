class WelcomeController < ApplicationController
  
  def index
    cookies[:texto] = "Cookie com um texto"
    cookies[:numero] = 1
    cookies[:hash] = { nome: "Victor", idade: 26 }
    
    session[:texto] = "Session com um texto"
    session[:numero] = 1
    session[:hash] = { nome: "Victor", idade: 26 }
  end
end
