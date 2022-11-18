# frozen_string_literal: true
require 'spec_helper'
require 'minilogger'
require 'minilogger/my_reverse_logger'

RSpec.describe Minilogger::MyLogger do

  it 'write error log' do
    Minilogger::MyLogger.new.error("Ohh no!")

    @buffer = StringIO.new()
    @filename = Minilogger::MyLogger.new.log_file
    @content = "Ohh no!"

    allow(File).to receive(:open).with(@filename,'w').and_yield( @buffer )
    File.open(@filename, 'w') {|f| f.write(@content)}
    expect(@buffer.string).to eq(@content)
  end

  it 'supports info' do
    expect(Minilogger::MyLogger.new.info('hello world')).to eq('[INFO] hello world')
  end
  it 'supports warn' do
    expect(Minilogger::MyLogger.new.warn('this is a warning')).to eq('[WARN] this is a warning')
  end
  it 'supports error' do
    expect(Minilogger::MyLogger.new.error('this is an error')).to eq('[ERROR] this is an error')
  end

  it 'supports buffered output' do
    my_logger = Minilogger::MyLogger.new(warn_size: 2, error_size: 3)

    expect(my_logger.info('hello')).to eq('[INFO] hello')
    expect(my_logger.warn('blabla')).to be_nil
    expect(my_logger.warn('umbrella')).to eq(['[WARN] blabla', '[WARN] umbrella'].join("\n"))
    expect(my_logger.warn('hello')).to be_nil
    expect(my_logger.error('oops')).to be_nil
    expect(my_logger.error('oopsie')).to be_nil
    expect(my_logger.warn('what')).to eq(['[WARN] hello', '[WARN] what'].join("\n"))
    expect(my_logger.error('ouch')).to eq(['[ERROR] oops', '[ERROR] oopsie', '[ERROR] ouch'].join("\n"))
  end

  it 'supports tagged output' do
    my_logger = Minilogger::MyLogger.new(tags: %w[unosquare verisk])
    expect(my_logger.info('ok fine!')).to eq('[UNOSQUARE][VERISK][INFO] ok fine!')
  end

  it 'supports tagged buffered output' do
    my_logger = Minilogger::MyLogger.new(info_size: 4, warn_size: 2,error_size: 3, tags: %w[API g2])

    expect(my_logger.info('first')).to be_nil
    expect(my_logger.warn('blablabla')).to be_nil
    expect(my_logger.warn('umbrellas')).to eq(['[API][G2][WARN] blablabla', '[API][G2][WARN] umbrellas'].join("\n"))
    expect(my_logger.info('second')).to be_nil
    expect(my_logger.info('third')).to be_nil
    expect(my_logger.warn('hello')).to be_nil
    expect(my_logger.error('oops')).to be_nil
    expect(my_logger.error('oopsie')).to be_nil
    expect(my_logger.info('fourth')).to eq(['[API][G2][INFO] first', '[API][G2][INFO] second', '[API][G2][INFO] third', '[API][G2][INFO] fourth'].join("\n"))
    expect(my_logger.warn('what')).to eq(['[API][G2][WARN] hello', '[API][G2][WARN] what'].join("\n"))
    expect(my_logger.error('ouch')).to eq(['[API][G2][ERROR] oops', '[API][G2][ERROR] oopsie', '[API][G2][ERROR] ouch'].join("\n"))
  end
end
  #####################################################################################

RSpec.describe Minilogger::MyReverseLogger do

  it 'writes messages in reverse' do
    expect(Minilogger::MyReverseLogger.new.info('hello world')).to eq('[INFO] dlrow olleh')
    expect(Minilogger::MyReverseLogger.new.warn('a warn')).to eq('[WARN] nraw a')
    expect(Minilogger::MyReverseLogger.new.error('an error')).to eq('[ERROR] rorre na')
  end
end
