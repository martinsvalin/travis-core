# TODO check these ...
RSpec.shared_examples_for 'a build configuration' do
  combinations = [
    [nil,   true,  { :notifications => { :on_success => 'always' } }, true ],
    [true,  true,  { :notifications => { :on_success => 'always' } }, true ],
    [false, true,  { :notifications => { :on_success => 'always' } }, true ],

    [nil,   false, { :notifications => { :on_success => 'always' } }, true ],
    [true,  false, { :notifications => { :on_success => 'always' } }, true ],
    [false, false, { :notifications => { :on_success => 'always' } }, true ],

    [nil,   true,  { :notifications => { :on_failure => 'always' } }, true ],
    # [true,  true,  { :notifications => { :on_failure => 'always' } }, true ],
    [false, true,  { :notifications => { :on_failure => 'always' } }, true ],

    [nil,   false, { :notifications => { :on_failure => 'always' } }, true ],
    [true,  false, { :notifications => { :on_failure => 'always' } }, true ],
    [false, false, { :notifications => { :on_failure => 'always' } }, true ],


    [nil,   true,  { :notifications => { :on_success => 'change' } }, true ],
    [true,  true,  { :notifications => { :on_success => 'change' } }, false ],
    [false, true,  { :notifications => { :on_success => 'change' } }, true ],

    [nil,   false, { :notifications => { :on_success => 'change' } }, true ],
    [true,  false, { :notifications => { :on_success => 'change' } }, true ],
    [false, false, { :notifications => { :on_success => 'change' } }, true ],

    [nil,   true,  { :notifications => { :on_failure => 'change' } }, true ],
    # [true,  true,  { :notifications => { :on_failure => 'change' } }, true ], # TODO
    [false, true,  { :notifications => { :on_failure => 'change' } }, true ],

    [nil,   false, { :notifications => { :on_failure => 'change' } }, false ],
    [true,  false, { :notifications => { :on_failure => 'change' } }, true ],
    [false, false, { :notifications => { :on_failure => 'change' } }, false ],


    [nil,   true,  { :notifications => { :on_success => 'never' } }, false ],
    [true,  true,  { :notifications => { :on_success => 'never' } }, false ],
    [false, true,  { :notifications => { :on_success => 'never' } }, false ],

    [nil,   false, { :notifications => { :on_success => 'never' } }, true ],
    [true,  false, { :notifications => { :on_success => 'never' } }, true ],
    [false, false, { :notifications => { :on_success => 'never' } }, true ],

    [nil,   true,  { :notifications => { :on_failure => 'never' } }, true ],
    # [true,  true,  { :notifications => { :on_failure => 'never' } }, true ], # TODO
    [false, true,  { :notifications => { :on_failure => 'never' } }, true ],

    [nil,   false, { :notifications => { :on_failure => 'never' } }, false ],
    [true,  false, { :notifications => { :on_failure => 'never' } }, false ],
    [false, false, { :notifications => { :on_failure => 'never' } }, false ],
  ]
  results = { nil => 'is missing', true => 'passed', false => 'failed' }

  combinations.each do |previous, current, data, result|
    it "returns #{result} if the previous build #{results[previous]}, the current build #{results[current]} and config is #{data}" do
      data = build.config.deep_merge(data)
      build.stubs(:config => data, :passed? => current, :failed? => !current, :previous_passed? => previous)
      config.send_on_finish?.should == result
    end
  end
end


