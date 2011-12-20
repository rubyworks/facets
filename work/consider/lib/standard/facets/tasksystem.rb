# = TITLE:
#
#   Tasks
#
# = COPYING:
#
#   Copyright (c) 2007,2008 Tiger Ops
#
#   This file is part of the Reap program.
#
#   Reap is free software: you can redistribute it and/or modify
#   it under the terms of the GNU General Public License as published by
#   the Free Software Foundation, either version 3 of the License, or
#   (at your option) any later version.
#
#   Reap is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with Reap.  If not, see <http://www.gnu.org/licenses/>.

#
module Reap

  module TaskSystem

    IN_PROGRESS = :__IN_PROGRESS__

    # Define main task.

    def main(name, &block)
      name, deps, block = *parse_dependencies(name, &block)
      define_main(name, *deps, &block)
    end

    # Define a task.

    def task(name, &block)
      name, deps, block = *parse_dependencies(name, &block)
      define_task(name, *deps, &block)
    end

    # Define a build target.

    def file(name, &block)
      name, deps, block = *parse_dependencies(name, &block)
      define_file(name, *deps, &block)
    end

    def goals
      @goals ||= {}
    end

    # Complete a goal.

    def run(goal)
      if rule = rules.find{ |r| r.match?(goal) }
        action = rule.action(goal)
        key = action.key
        if result = goals[key]
          if result == IN_PROGESS
            abort "Circular dependency -- #{goal}"
          else
            result
          end
        else
          goals[key] = IN_PROGRESS
          action.needs.each{ |need| run(need) }
          goals[key] = action.call
        end
      else
        files = Dir.glob(goal)
        if files.empty?
          abort "Missing dependency -- #{goal}"
        else
          true
        end
      end
    end

    #def run(goal, arguments=nil)
    #  plan(goal).each{ |action| action.call }
    #end

    private

      def rules ; @rules ||= [] ; end

      def main_rule ; @main ; end

      #

      def parse_dependencies(name_deps, &block)
        if Hash===name_deps
          name = name_deps.keys[0]
          deps = name_deps.values[0]
        else
          name = name_deps
          deps = []
        end
        [name, deps, block]
      end

      # Define main task.

      def define_main(name=nil, *depend, &block)
        @main = define_task(name, *depend, &block)
      end

      # Define a task rule.

      def define_task(name, *depend, &block)
        rule = Task.new(name, *depend, &block)
        rules << rule
        rule
      end

      # Define a file build rule.

      def define_file(name, *depend, &block)
        rule = Build.new(name, *depend, &block)
        rules << rule
        rule
      end

      # Call main task.
      #--
      # TODO If @main is nil try task by same name a file (?)
      #      If so, be careful of infinite loop via method_missing.
      #++

      def run_main
        return unless main_rule
        run(main_rule.target)
      end

#       # Build a plan of action given a goal. This is a recursive
#       # function building up the +todo+ list parameter.
#
#       def plan(goal, todo=[])
#         if rule = rules.find{ |r| r.match?(goal) }
#           todo << Action.new(goal, rule)
#           rule.needs.each do |need|
#             next if todo.any?{ |r| r.match?(need) }
#             plan(need, todo)
#           end
#         else
#           todo << Action.new(goal)
#         end
#         todo
#       end

=begin
      # Prepare plan, checking for circular dependencies.

      def task_plan(name, list=[])
        if list.include?(name)
          raise "Circular dependency #{name}."
        end

        if task = tasks[name]
          task.needs.each do |need|
            need = need.to_s
            next if list.include?(need)
            #@tasks[need].task_plan(need, list)
            task_plan(need, list)
          end
          list << task.name
        elsif name != main_task && fname = batch?(name)
          # TODO THIS TIES TASKS INTO BATCH, BETTER WAY?
          task = Task.new(name) do
            batch(fname)
          end
          tasks[name] = task
          list << task.name
        elsif build?(name)
          # TODO THIS TIES TASKS INTO BUILD, BETTER WAY?
          task = Task.new(name) do
            build(name)
          end
          tasks[name] = task
          list << task.name
        else
          abort "no task -- #{name}"
        end

        return list
      end
=end

    #

    class Rule
      attr_reader :target, :needs, :procedure

      def initialize(target, *needs, &procedure)
        @target        = target
        @needs         = needs
        @procedure     = procedure
      end

      def action(goal)
        Action.new(self, key(goal))
      end
    end

    # Task is a simpliest type of rule --a pure assertion. It stores a task name,
    # action and it's prerequisite needs.

    class Task < Rule

      def match?(goal)
        target.to_sym == goal.to_sym
      end

      def call(goal)
        procedure.call if procedure
      end

      def key(goal)
        goal.to_sym
      end

      #def action(goal)
      #  Action.new(self, key(goal))
      #end

      #def needed?(goal)
      #  true
      #end
    end

    # The Build class is a file rule. It encapsulates the procedure for
    # creating a file (or directory).

    class Build < Rule

      # Does a file match this build definition?

      def match?(path)
        return false unless String===path
        case target
        when String
          File.fnmatch(target, path)
        when Regexp
          target =~ path
        else
          false        # ???
        end
      end

      # Call this build process for the given path.

      def call(path)
        if needs.empty?
          dated = true
        elsif File.exist?(path)
          mtime = File.mtime(path)
          dated = needs.find do |file|
            !File.exist?(file) || File.mtime(file) > mtime
          end
        else
          dated = true
        end
        procedure.call(path) if dated
      end

      #

      def key(path)
        File.expand_path(path.to_s)
      end

  #     # Expanded needs.
  #
  #     def needs(key)
  #       needed_paths
  #     end
  #
  #     def needs
  #       #exact = needs.select{|n| File.fnmatch?(n,n)} +
  #       exact = needed.select{|n| n !~ /[\[*?]/ }
  #       globs = @needs.collect{|n| Dir.glob(n)}.flatten
  #       (exact + globs).uniq #globs.uniq
  #     end
  #
  #     # Is this build needed to update/create path?
  #
  #     def needed_for?(path)
  #       return true unless File.exist?(path)
  #       return true if needed_paths.empty?  # TODO: if there are no prereqs then the file is always considered needed. Correct?
  #       mtimes = needed_paths.collect do |f|
  #         File.exist?(f) ? File.mtime(f) : Time.now
  #       end
  #       mtimes.max > File.mtime(path)
  #     end
    end

    # An action associates a goal and the rule the fulfills it.

    class Action
      attr :rule
      attr :goal

      def initialize(rule, goal)
        @rule = rule
        @goal = goal
      end

      def key
        rule.key(goal)
      end

      def call
        rule.call(goal)
      end

      def needs
        rule.needs #(key)
      end

      def ==(other)
        case other
        when Action
          rule == other.rule && key == other.key
        else
          false
  #       when Rule
  #         rule.match?(other)
  #       else
  #         goal == other
  #       end
        end
      end

  #     def match?(need)
  #       if rule
  #         rule.match?(need)
  #       else
  #         goal == need
  #       end
  #     end

    end

  end

end
