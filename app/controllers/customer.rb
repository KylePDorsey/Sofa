get '/customer/new' do
  erb :'customer/new'
end

post '/customer' do
  @customer = Customer.new(first_name: params[:first_name], last_name: params[:last_name], email: params[:email], password: params[:password])
  if @customer.save
    session[:customer_id] = @customer.id
    redirect '/'
  else
    @register_error = "You entered something incorrectly! Please try again."
    erb :'/customer/new'
  end
end

get '/login' do
  erb :'customer/login'
end

post '/login' do
  @customer = customer.authenticate(params[:email], params[:password])
  if @customer
    session[:customer_id] = @customer.id
    redirect '/'
  else
    @login_error = "customer name or password is incorrect"
    erb :'/customer/login'
  end
end

get '/logout' do
  session[:customer_id] = nil
  redirect '/'
end

get '/customers/show' do
  if !logged_in?
    redirect '/'
  else
  @deck_names = []
  @customer = customer.find(session[:customer_id])
  @customer.rounds.each do |round|
    if round.guesses.length < round.deck.cards.length
      round.destroy
    end
    if !@deck_names.include? round.deck.name
        @deck_names << round.deck.name
        #in order to get first set of guesses from a round, will have to set an attribute on round...probably easist way
    end
  end
    erb :'/customer/show'
  end
end

