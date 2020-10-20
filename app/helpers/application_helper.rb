module ApplicationHelper
  def flash_class(flash_type)
    flash_types = {
      notice: 'alert-info',
      success: 'alert-success',
      error: 'alert-danger',
      alert: 'alert-warning'
    }

    flash_types[flash_type.to_sym]
  end
end
