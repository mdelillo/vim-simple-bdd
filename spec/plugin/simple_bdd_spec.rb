require 'spec_helper'

describe 'Vim Simple BDD' do
  specify 'Generating a simple_bdd method declaration' do
    Given 'I have a Given statement'
    When 'I run SimpleBDD on the statement'
    Then 'It becomes a method declaration'
    And 'I end up in insert mode inside of the method with the correct indentation'
  end

  specify 'Generating multiple simple_bdd method declarations in normal mode' do
    Given 'I have multiple Given/When/Then statements'
    When 'I run SimpleBDD on the statements in normal mode'
    Then 'They become method declarations'
  end

  specify 'Generating multiple simple_bdd method declarations in visual mode' do
    Given 'I have multiple Given/When/Then statements'
    When 'I run SimpleBDD on the statements in visual mode'
    Then 'They become method declarations'
  end

  specify 'Ignoring lines that are not simple_bdd statements' do
    Given 'I have lines that do not contain simple_bdd statements'
    When 'I run SimpleBDD on all of the lines'
    Then 'Those lines are not changed'
  end

  def i_have_a_given_statement
    write_file('test.rb', <<-EOF)
      Given 'I   am a *Very* Important   Person/Place/Thing'
    EOF
  end

  def i_run_simplebdd_on_the_statement
    vim.edit('test.rb')
    vim.type(':SimpleBDD<CR>')
    vim.write
  end

  def it_becomes_a_method_declaration
    expect(IO.read('test.rb').strip).to eq <<-EOF.gsub(/^ */, '').strip
      def i_am_a_very_important_person_place_thing
      \t
      end
    EOF
  end

  def i_end_up_in_insert_mode_inside_of_the_method_with_the_correct_indentation
    vim.type('I am typing')
    vim.write
    expect(IO.read('test.rb').strip).to eq normalize_string_indent(<<-EOF)
      def i_am_a_very_important_person_place_thing
      \tI am typing
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

  def i_run_simplebdd_on_the_statements_in_normal_mode
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

  def i_run_simplebdd_on_the_statements_in_visual_mode
    vim.edit('test.rb')
    vim.normal('Vjj:SimpleBDD<CR>')
    vim.write
  end

  def i_have_lines_that_do_not_contain_simple_bdd_statements
    write_file('test.rb', <<-EOF)
      it 'works correctly' do
        Given 'A simple_bdd statement'

        Ignoring 'A red herring'

        # a comment
        behavior 'stuff' do
          when 'Something happens'
          then 'It works!'
        end
      end
    EOF
  end

  def i_run_simplebdd_on_all_of_the_lines
    vim.edit('test.rb')
    vim.command('%SimpleBDD')
    vim.write
  end

  def those_lines_are_not_changed
    expect(IO.read('test.rb').strip).to eq normalize_string_indent(<<-EOF)
      it 'works correctly' do
        def a_simple_bdd_statement
        end

        Ignoring 'A red herring'

        # a comment
        behavior 'stuff' do
          def something_happens
          end
          def it_works
          end
        end
      end
    EOF
  end
end
