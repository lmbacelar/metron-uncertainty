require 'spec_helper'

describe MeasurementModel do
  it 'saves attributes' do

    equation = <<-EQUATION
[m]*(1-[r_air]/[r_mas])*[gl] / ([Aef]*(1+([alpha_c]+[alpha_p])*([T]-[T0]))*(1+[lambda]*[p])) - ([r_col]-[r_air])*[gl]*[h]
    EQUATION
    measurement_model = MeasurementModel.new(name: 'PC.40601',
                                             description: 'Pressure gauge calibration using a piston gauge',
                                             equation: equation)
    measurement_model.save!
    expect(measurement_model).to be_valid
  end

end
