module ApplicationHelper

  def personal_devise_error_messages!
    return '' if resource.errors.empty?

    sentence = "#{resource.errors.count} errors prohibited this #{resource.class.model_name.human.downcase} from being saved:"
    messages = resource.errors.full_messages.map { |msg|
      content_tag :li, msg
    }.join

    html = <<-HTML
    <div class="alert alert-danger alert-block devise-bs">
      <button type="button" class="close" data-dismiss="alert">&times;</button>
      <h5>#{sentence}</h5>
      <ul>#{messages}</ul>
    </div>
    HTML

    html.html_safe
  end
end
