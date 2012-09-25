require 'spec_helper'

describe Field do
    it { should belong_to(:field_type) }
end
