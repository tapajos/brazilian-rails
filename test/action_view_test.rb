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
      def Post.content_columns() [ Column.new(:string, "title", "Title"), Column.new(:text, "body", "Body") ] end
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

  def test_form_with_string_multipart
    assert_dom_equal(
      %(<form action="create" enctype="multipart/form-data" method="post"><p><label for="post_title">Title</label><br /><input id="post_title" name="post[title]" size="30" type="text" value="Hello World" /></p>\n<p><label for="post_body">Body</label><br /><div class="fieldWithErrors"><textarea cols="40" id="post_body" name="post[body]" rows="20">Back to the hill and over it again!</textarea></div></p><input name="commit" type="submit" value="Create" /></form>),
      form("post", :multipart => true)
    )
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

end
