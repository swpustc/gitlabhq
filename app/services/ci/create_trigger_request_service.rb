module Ci
  class CreateTriggerRequestService
    def execute(project, trigger, ref, variables = nil)
      commit = project.gl_project.commit(ref)
      return unless commit

      ci_commit = project.gl_project.ensure_ci_commit(commit.sha)
      trigger_request = trigger.trigger_requests.create!(
        variables: variables
      )

      if ci_commit.create_builds(ref, tag, nil, trigger_request)
        trigger_request
      end
    end
  end
end
