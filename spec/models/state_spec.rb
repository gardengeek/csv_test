require 'spec_helper'

describe State do
  fixtures :states

  describe '.to_options' do
    it 'finds all of the states and return their code/name and id in pairs' do
      State.to_options.first(9).should == [
        ['AA - Armed Forces Americas', states(:states_73).id],
        ['AE - Armed Forces', states(:states_74).id],
        ['AK - Alaska', states(:states_15).id],
        ['AL - Alabama', states(:states_14).id],
        ['AP - Armed Forces Pacific', states(:states_75).id],
        ['AR - Arkansas', states(:states_18).id],
        ['AS - American Samoa', states(:states_16).id],
        ['AZ - Arizona', states(:states_17).id],
        ['CA - California', states(:states_19).id]
      ]
    end
  end
end
