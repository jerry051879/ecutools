##
# ecutools: IoT Automotive Tuning, Diagnostics & Analytics
# Copyright (C) 2014 Jeremy Hahn
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

require 'spec_helper'

describe Ecutools::J2534 do
  include_context 'J2534' do
    context 'PassThruConnect' do

  # Needs to be moved to PassThruOpen - good night!

      it 'returns ERR_DEVICE_IN_USE when called after already being successfully called' do
        things.test_with_ecutuned {

          resource = Ecutools::J2534::Models::Resource.new
          resource.Connector = Ecutools::J2534::J1962_CONNECTOR
          expect(j2534.PassThruConnect(1, Ecutools::J2534::CAN, Ecutools::J2534::CAN_ID_BOTH, 500000, resource, 1)).to eq(true)
          expect {
            j2534.PassThruConnect(1, Ecutools::J2534::CAN, Ecutools::J2534::CAN_ID_BOTH, 500000, resource, 1)
          }.to raise_error Ecutools::J2534Error, /ERR_DEVICE_IN_USE/
        }
      end

    end
  end
end
