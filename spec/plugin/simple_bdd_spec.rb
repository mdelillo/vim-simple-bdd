require 'spec_helper'

describe 'Vim Simple BDD' do
  specify 'Generating a simple_bdd method declaration' do
    Given 'I have a Given statement'
    When 'I run the plugin on the statement'
    Then 'It becomes a method declaration'
  end

  specify 'Generating multiple simple_bdd method declarations in normal mode' do
    Given 'I have multiple Given/When/Then statements'
    When 'I run the plugin on the statements'
    Then 'They become method declarations'
  end

  def i_have_a_given_statement
    write_file('test.rb', <<-EOF)
      Given 'I   am a *Very* Important   Person/Place/Thing'
    EOF
  end

  def i_run_the_plugin_on_the_statement
    vim.edit('test.rb')
    vim.command('SimpleBDD')
    vim.write
  end

  def it_becomes_a_method_declaration
    expect(IO.read('test.rb').strip).to eq normalize_string_indent(<<-EOF)
      def i_am_a_very_important_person_place_thing
      end
    EOF
  end

  def i_have_multiple_given_when_then_statements
    write_file('test.rb', <<-EOF)
      Given 'Some state'
      When 'Something happens'
      Then 'Something changes'
    EOF
  end

  def i_run_the_plugin_on_the_statements
    vim.edit('test.rb')
    vim.command('1,3SimpleBDD')
    vim.write
  end

  def they_become_method_declarations
    expect(IO.read('test.rb').strip).to eq normalize_string_indent(<<-EOF)
      def some_state
      end
      def something_happens
      end
      def something_changes
      end
    EOF
  end
end
