class RExpressionValidator < ActiveModel::EachValidator
  def validate_each record, attribute, value
    begin
      R.command "parse(text='#{value}')"
    rescue Rserve::Connection::EvalError
      record.errors[attribute] << 'is not a valid R expression'
    end
  end
end
