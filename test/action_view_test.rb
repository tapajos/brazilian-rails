require File.dirname(__FILE__) + '/test_helper'
require 'mocha'

class ActionViewTest < Test::Unit::TestCase
  
  include ActionView::Helpers::FormHelper
  include ActionView::Helpers::ActiveRecordHelper
  include ActionView::Helpers::TextHelper
  include ActionView::Helpers::TagHelper
  include ActionView::Helpers::UrlHelper
  include ActionView::Helpers::FormTagHelper
  include ActionView::Helpers::DateHelper
  include ActionView::Helpers::FormOptionsHelper
  
  silence_warnings do
    Post = Struct.new("Post", :title, :author_name, :body, :secret, :written_on)
    Post.class_eval do
      alias_method :title_before_type_cast, :title unless respond_to?(:title_before_type_cast)
      alias_method :body_before_type_cast, :body unless respond_to?(:body_before_type_cast)
      alias_method :author_name_before_type_cast, :author_name unless respond_to?(:author_name_before_type_cast)
    end
    
    User = Struct.new("User", :email)
    User.class_eval do
      alias_method :email_before_type_cast, :email unless respond_to?(:email_before_type_cast)
    end
    
    Column = Struct.new("Column", :type, :name, :human_name)
  end
  
  def setup_post
    @post = Post.new    
    def @post.errors
      Class.new {
        def on(field) field == "author_name" || field == "body" end
        def empty?() false end 
        def count() 1 end 
        def full_messages() [ "Author name can't be empty" ] end
      }.new
    end
    
    def @post.new_record?() true end
    def @post.to_param() nil end

    def @post.column_for_attribute(attr_name)
      Post.content_columns.select { |column| column.name == attr_name }.first
    end

    silence_warnings do
      def Post.content_columns() [ Column.new(:string, "title", "Title"), 
                                   Column.new(:text, "body", "Body") ] 
      end
    end

    @post.title       = "Hello World"
    @post.author_name = ""
    @post.body        = "Back to the hill and over it again!"
    @post.secret = 1
    @post.written_on  = Date.new(2004, 6, 15)
  end
  
  def setup_user
    @user = User.new    
    def @user.errors
      Class.new {
        def on(field) field == "email" end
        def empty?() false end 
        def count() 1 end 
        def full_messages() [ "User email can't be empty" ] end
      }.new
    end
    
    def @user.new_record?() true end
    def @user.to_param() nil end

    def @user.column_for_attribute(attr_name)
      User.content_columns.select { |column| column.name == attr_name }.first
    end

    silence_warnings do
      def User.content_columns() [ Column.new(:string, "email", "Email") ] end
    end

    @user.email = ""
  end

  def setup
    setup_post
    setup_user

    @controller = Object.new
    def @controller.url_for(options)
      options = options.symbolize_keys

      [options[:action], options[:id].to_param].compact.join('/')
    end
  end
  
  def test_error_for_block
    assert_dom_equal %(<div class=\"errorExplanation\" id=\"errorExplanation\"><h2>1 erro para post</h2><p>Foram detectados os seguintes erros:</p><ul><li>Author name can't be empty</li></ul></div>), error_messages_for("post")
    assert_equal %(<div class=\"errorDeathByClass\" id=\"errorDeathById\"><h1>1 erro para post</h1><p>Foram detectados os seguintes erros:</p><ul><li>Author name can't be empty</li></ul></div>), error_messages_for("post", :class => "errorDeathByClass", :id => "errorDeathById", :header_tag => "h1")
    assert_equal %(<div id=\"errorDeathById\"><h1>1 erro para post</h1><p>Foram detectados os seguintes erros:</p><ul><li>Author name can't be empty</li></ul></div>), error_messages_for("post", :class => nil, :id => "errorDeathById", :header_tag => "h1")
    assert_equal %(<div class=\"errorDeathByClass\"><h1>1 erro para post</h1><p>Foram detectados os seguintes erros:</p><ul><li>Author name can't be empty</li></ul></div>), error_messages_for("post", :class => "errorDeathByClass", :id => nil, :header_tag => "h1")
  end
  
  def test_error_messages_for_handles_nil
    assert_equal "", error_messages_for("notthere")
  end
  
  def test_error_message_on_handles_nil
    assert_equal "", error_message_on("notthere", "notthere")
  end
  
  def test_error_message_on
    assert error_message_on(:post, :author_name)
  end
  
  def test_error_messages_for_many_objects
    assert_dom_equal %(<div class=\"errorExplanation\" id=\"errorExplanation\"><h2>2 erros para post</h2><p>Foram detectados os seguintes erros:</p><ul><li>Author name can't be empty</li><li>User email can't be empty</li></ul></div>), error_messages_for("post", "user")

    # reverse the order, error order changes and so does the title
    assert_dom_equal %(<div class=\"errorExplanation\" id=\"errorExplanation\"><h2>2 erros para user</h2><p>Foram detectados os seguintes erros:</p><ul><li>User email can't be empty</li><li>Author name can't be empty</li></ul></div>), error_messages_for("user", "post")

    # add the default to put post back in the title
    assert_dom_equal %(<div class=\"errorExplanation\" id=\"errorExplanation\"><h2>2 erros para post</h2><p>Foram detectados os seguintes erros:</p><ul><li>User email can't be empty</li><li>Author name can't be empty</li></ul></div>), error_messages_for("user", "post", :object_name => "post")
    
    # symbols work as well
    assert_dom_equal %(<div class=\"errorExplanation\" id=\"errorExplanation\"><h2>2 erros para post</h2><p>Foram detectados os seguintes erros:</p><ul><li>User email can't be empty</li><li>Author name can't be empty</li></ul></div>), error_messages_for(:user, :post, :object_name => :post)
    
    # any default works too
    assert_dom_equal %(<div class=\"errorExplanation\" id=\"errorExplanation\"><h2>2 erros para monkey</h2><p>Foram detectados os seguintes erros:</p><ul><li>User email can't be empty</li><li>Author name can't be empty</li></ul></div>), error_messages_for(:user, :post, :object_name => "monkey")
  end

  def test_distance_of_time_in_words
    assert_equal "menos de um minuto", distance_of_time_in_words("Sat Sep 08 22:51:58 -0300 2007".to_time, "Sat Sep 08 22:51:59 -0300 2007".to_time)
    assert_equal "menos de 5 segundos", distance_of_time_in_words("Sat Sep 08 22:51:58 -0300 2007".to_time, "Sat Sep 08 22:51:59 -0300 2007".to_time, true)
    assert_equal "menos de 10 segundos", distance_of_time_in_words("Sat Sep 08 22:51:50 -0300 2007".to_time, "Sat Sep 08 22:51:55 -0300 2007".to_time, true)
    assert_equal "menos de 20 segundos", distance_of_time_in_words("Sat Sep 08 22:51:00 -0300 2007".to_time, "Sat Sep 08 22:51:10 -0300 2007".to_time, true)
    assert_equal "meio minuto", distance_of_time_in_words("Sat Sep 08 22:51:00 -0300 2007".to_time, "Sat Sep 08 22:51:20 -0300 2007".to_time, true)
    assert_equal "menos de um minuto", distance_of_time_in_words("Sat Sep 08 22:51:00 -0300 2007".to_time, "Sat Sep 08 22:51:40 -0300 2007".to_time, true)
    assert_equal "1 minuto", distance_of_time_in_words("Sat Sep 08 22:51:00 -0300 2007".to_time, "Sat Sep 08 22:52:00 -0300 2007".to_time, true)
    assert_equal "1 minuto", distance_of_time_in_words("Sat Sep 08 22:51:59 -0300 2007".to_time, "Sat Sep 08 22:52:59 -0300 2007".to_time)
    assert_equal "2 minutos", distance_of_time_in_words("Sat Sep 08 22:51:59 -0300 2007".to_time, "Sat Sep 08 22:53:59 -0300 2007".to_time)
    assert_equal "aproximadamente 1 hora", distance_of_time_in_words("Sat Sep 08 21:51:59 -0300 2007".to_time, "Sat Sep 08 22:51:59 -0300 2007".to_time)
    assert_equal "aproximadamente 2 horas", distance_of_time_in_words("Sat Sep 08 20:51:59 -0300 2007".to_time, "Sat Sep 08 22:51:59 -0300 2007".to_time)
    assert_equal "1 dia", distance_of_time_in_words("Sat Sep 07 20:51:59 -0300 2007".to_time, "Sat Sep 08 20:51:59 -0300 2007".to_time)
    assert_equal "2 dias", distance_of_time_in_words("Sat Sep 06 20:51:59 -0300 2007".to_time, "Sat Sep 08 20:51:59 -0300 2007".to_time)
    assert_equal "aproximadamente 1 mês", distance_of_time_in_words("Sat Oct 06 20:51:59 -0300 2007".to_time, "Sat Sep 06 20:51:59 -0300 2007".to_time)
    assert_equal "2 meses", distance_of_time_in_words("Sat Nov 06 20:51:59 -0300 2007".to_time, "Sat Sep 06 20:51:59 -0300 2007".to_time)
    assert_equal "12 meses", distance_of_time_in_words("Sat Nov 06 20:51:59 -0300 2006".to_time, "Sat Nov 06 20:51:59 -0300 2007".to_time)
    assert_equal "aproximadamente 1 ano", distance_of_time_in_words("Sat Nov 06 20:51:59 -0300 2006".to_time, "Sat Dec 06 20:51:59 -0300 2007".to_time)
    assert_equal "mais de 3 anos", distance_of_time_in_words("Sat Nov 06 20:51:59 -0300 2006".to_time, "Sat Dec 06 20:51:59 -0300 2009".to_time)
  end
  
  def test_option_estados_for_select
    assert_equal %(<option value=\"AC\">Acre</option>\n<option value=\"AL\">Alagoas</option>\n<option value=\"AP\">Amapá</option>\n<option value=\"AM\">Amazonas</option>\n<option value=\"BA\">Bahia</option>\n<option value=\"CE\">Ceará</option>\n<option value=\"DF\">Distrito Federal</option>\n<option value=\"ES\">Espírito Santos</option>\n<option value=\"GO\">Goiás</option>\n<option value=\"MA\">Maranhão</option>\n<option value=\"MT\">Mato Grosso</option>\n<option value=\"MS\">Mato Grosso do Sul</option>\n<option value=\"MG\">Minas Gerais</option>\n<option value=\"PA\">Pará</option>\n<option value=\"PB\">Paraíba</option>\n<option value=\"PR\">Paraná</option>\n<option value=\"PE\">Pernambuco</option>\n<option value=\"PI\">Piauí</option>\n<option value=\"RJ\">Rio de Janeiro</option>\n<option value=\"RN\">Rio Grande do Norte</option>\n<option value=\"RS\">Rio Grande do Sul</option>\n<option value=\"RO\">Rondônia</option>\n<option value=\"RR\">Roraima</option>\n<option value=\"SC\">Santa Catarina</option>\n<option value=\"SP\">São Paulo</option>\n<option value=\"SE\">Sergipe</option>\n<option value=\"TO\">Tocantins</option>), option_estados_for_select
  end

  def test_option_uf_for_select
    assert_equal %(<option value=\"AC\">AC</option>\n<option value=\"AL\">AL</option>\n<option value=\"AP\">AP</option>\n<option value=\"AM\">AM</option>\n<option value=\"BA\">BA</option>\n<option value=\"CE\">CE</option>\n<option value=\"DF\">DF</option>\n<option value=\"ES\">ES</option>\n<option value=\"GO\">GO</option>\n<option value=\"MA\">MA</option>\n<option value=\"MT\">MT</option>\n<option value=\"MS\">MS</option>\n<option value=\"MG\">MG</option>\n<option value=\"PA\">PA</option>\n<option value=\"PB\">PB</option>\n<option value=\"PR\">PR</option>\n<option value=\"PE\">PE</option>\n<option value=\"PI\">PI</option>\n<option value=\"RJ\">RJ</option>\n<option value=\"RN\">RN</option>\n<option value=\"RS\">RS</option>\n<option value=\"RO\">RO</option>\n<option value=\"RR\">RR</option>\n<option value=\"SC\">SC</option>\n<option value=\"SP\">SP</option>\n<option value=\"SE\">SE</option>\n<option value=\"TO\">TO</option>), option_uf_for_select
  end
  
  def test_select_estado
    assert_equal %(<select id=\"lancamento_estado\" name=\"lancamento[estado]\"><option value=\"AC\">Acre</option>\n<option value=\"AL\">Alagoas</option>\n<option value=\"AP\">Amapá</option>\n<option value=\"AM\">Amazonas</option>\n<option value=\"BA\">Bahia</option>\n<option value=\"CE\">Ceará</option>\n<option value=\"DF\">Distrito Federal</option>\n<option value=\"ES\">Espírito Santos</option>\n<option value=\"GO\">Goiás</option>\n<option value=\"MA\">Maranhão</option>\n<option value=\"MT\">Mato Grosso</option>\n<option value=\"MS\">Mato Grosso do Sul</option>\n<option value=\"MG\">Minas Gerais</option>\n<option value=\"PA\">Pará</option>\n<option value=\"PB\">Paraíba</option>\n<option value=\"PR\">Paraná</option>\n<option value=\"PE\">Pernambuco</option>\n<option value=\"PI\">Piauí</option>\n<option value=\"RJ\">Rio de Janeiro</option>\n<option value=\"RN\">Rio Grande do Norte</option>\n<option value=\"RS\">Rio Grande do Sul</option>\n<option value=\"RO\">Rondônia</option>\n<option value=\"RR\">Roraima</option>\n<option value=\"SC\">Santa Catarina</option>\n<option value=\"SP\">São Paulo</option>\n<option value=\"SE\">Sergipe</option>\n<option value=\"TO\">Tocantins</option></select>), select_estado(:lancamento, :estado)
  end
  
  def test_select_uf
    options = {:options1 => "1"}
    html_options = {:name => "name"}
    expects(:select).with(:lancamento, :estado, ['AC', 'AL', 'AP', 'AM', 'BA', 'CE', 'DF', 'ES', 'GO', 'MA', 'MT', 'MS', 'MG', 'PA', 'PB', 'PR', 'PE', 'PI', 'RJ', 'RN', 'RS', 'RO', 'RR', 'SC', 'SP', 'SE', 'TO'], {:options1 => '1'}, {:name => 'name'}).returns("select")
    assert_equal "select", select_uf(:lancamento, :estado, options, html_options)
  end
end
