# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "gritano"
  s.version = "0.9.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Igor Bonadio"]
  s.date = "2013-04-18"
  s.description = "Gritano is the simplest way to configure your git server over ssh. You can create repositories and manage user access."
  s.email = "igorbonadio@gmail.com"
  s.executables = ["gritano", "gritano-pub-key", "gritano-remote"]
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.rdoc",
    "TODO"
  ]
  s.files = [
    ".document",
    ".gritano/config.yml",
    ".gritano/database.yml",
    ".rspec",
    ".ssh/.gitignore",
    ".travis.yml",
    "Gemfile",
    "Gemfile.lock",
    "LICENSE.txt",
    "README.rdoc",
    "Rakefile",
    "VERSION",
    "bin/gritano",
    "bin/gritano-pub-key",
    "bin/gritano-remote",
    "db/migrate/001_create_users.rb",
    "db/migrate/002_create_repositories.rb",
    "db/migrate/003_create_permissions.rb",
    "db/migrate/004_create_keys.rb",
    "db/migrate/005_add_admin_to_users.rb",
    "db/migrate/006_add_email_to_users.rb",
    "features/data/config_true.yml",
    "features/data/local_commands/addon_list.txt",
    "features/data/local_commands/addon_ssh_install.txt",
    "features/data/local_commands/plugin_add_ssh.txt",
    "features/data/local_commands/plugin_add_sshs.txt",
    "features/data/local_commands/plugin_exec_ssh_help.txt",
    "features/data/local_commands/plugin_exec_ssh_helps.txt",
    "features/data/local_commands/plugin_exec_sshs_help.txt",
    "features/data/local_commands/plugin_info_ssh.txt",
    "features/data/local_commands/plugin_info_sshs.txt",
    "features/data/local_commands/plugin_list.txt",
    "features/data/local_commands/plugin_rm_ssh.txt",
    "features/data/local_commands/plugin_rm_sshs.txt",
    "features/data/local_commands/repo_add_tmp_jeka_git.txt",
    "features/data/local_commands/repo_add_tmp_p_lang_git.txt",
    "features/data/local_commands/repo_add_tmp_p_lang_git_igorbonadio.txt",
    "features/data/local_commands/repo_add_tmp_p_lang_git_igorbonadio_jessicaeto.txt",
    "features/data/local_commands/repo_list.txt",
    "features/data/local_commands/repo_read_add_tmp_gritano_git_arybonadio.txt",
    "features/data/local_commands/repo_read_add_tmp_gritano_git_jessicaeto.txt",
    "features/data/local_commands/repo_read_add_tmp_p_lang_git_jessicaeto.txt",
    "features/data/local_commands/repo_read_rm_tmp_jeka_git_aribonadio.txt",
    "features/data/local_commands/repo_read_rm_tmp_jeka_git_igorbonadio.txt",
    "features/data/local_commands/repo_read_rm_tmp_p_lang_git_igorbonadio.txt",
    "features/data/local_commands/repo_rm_tmp_jeka_git.txt",
    "features/data/local_commands/repo_rm_tmp_p_lang_git.txt",
    "features/data/local_commands/repo_user_list_tmp_jeka_git.txt",
    "features/data/local_commands/repo_user_list_tmp_ruby_git.txt",
    "features/data/local_commands/repo_write_add_tmp_gritano_git_arybonadio.txt",
    "features/data/local_commands/repo_write_add_tmp_gritano_git_jessicaeto.txt",
    "features/data/local_commands/repo_write_add_tmp_p_lang_git_jessicaeto.txt",
    "features/data/local_commands/repo_write_rm_tmp_gritano_git_arybonadio.txt",
    "features/data/local_commands/repo_write_rm_tmp_gritano_git_igorbonadio.txt",
    "features/data/local_commands/repo_write_rm_tmp_p_lang_git_igorbonadio.txt",
    "features/data/local_commands/user_add_igorbonadio.txt",
    "features/data/local_commands/user_add_jose.txt",
    "features/data/local_commands/user_admin_add_arybonadio.txt",
    "features/data/local_commands/user_admin_add_igorbonadio.txt",
    "features/data/local_commands/user_admin_rm_arybonadio.txt",
    "features/data/local_commands/user_admin_rm_igorbonadio.txt",
    "features/data/local_commands/user_email_get_igorbonadio.txt",
    "features/data/local_commands/user_email_get_jessicaeto.txt",
    "features/data/local_commands/user_email_get_wrong.txt",
    "features/data/local_commands/user_email_update_igorbonadio_igor@bonadio_com.txt",
    "features/data/local_commands/user_email_update_wrong_igor@bonadio_com.txt",
    "features/data/local_commands/user_key_add_igorbonadio_marvin.txt",
    "features/data/local_commands/user_key_add_userrr_marvino.txt",
    "features/data/local_commands/user_key_list_arybonadio.txt",
    "features/data/local_commands/user_key_list_igorbonadio.txt",
    "features/data/local_commands/user_key_rm_igorbonadio_eva.txt",
    "features/data/local_commands/user_key_rm_igorbonadio_marvino.txt",
    "features/data/local_commands/user_list.txt",
    "features/data/local_commands/user_repo_list_arybonadio.txt",
    "features/data/local_commands/user_repo_list_igorbonadio.txt",
    "features/data/local_commands/user_rm_igorbonadio.txt",
    "features/data/local_commands/user_rm_jose.txt",
    "features/data/local_commands/version.txt",
    "features/data/local_help.txt",
    "features/data/remote_commands/admin_addon_list_igorbonadio.txt",
    "features/data/remote_commands/admin_addon_list_jessicaeto.txt",
    "features/data/remote_commands/admin_help_igorbonadio.txt",
    "features/data/remote_commands/admin_help_jessicaeto.txt",
    "features/data/remote_commands/admin_plugin_exec_ssh_help_igorbonadio.txt",
    "features/data/remote_commands/admin_plugin_exec_ssh_help_jessicaeto.txt",
    "features/data/remote_commands/admin_plugin_exec_ssh_helps_igorbonadio.txt",
    "features/data/remote_commands/admin_plugin_exec_ssh_helps_jessicaeto.txt",
    "features/data/remote_commands/admin_plugin_exec_sshs_help_igorbonadio.txt",
    "features/data/remote_commands/admin_plugin_exec_sshs_help_jessicaeto.txt",
    "features/data/remote_commands/admin_plugin_info_ssh_igorbonadio.txt",
    "features/data/remote_commands/admin_plugin_info_ssh_jessicaeto.txt",
    "features/data/remote_commands/admin_plugin_info_sshs_igorbonadio.txt",
    "features/data/remote_commands/admin_plugin_info_sshs_jessicaeto.txt",
    "features/data/remote_commands/admin_plugin_list_igorbonadio.txt",
    "features/data/remote_commands/admin_plugin_list_jessicaeto.txt",
    "features/data/remote_commands/admin_repo_add_tmp_jeka_git_igorbonadio.txt",
    "features/data/remote_commands/admin_repo_add_tmp_jeka_git_jessicaeto.txt",
    "features/data/remote_commands/admin_repo_add_tmp_p_lang_git_igorbonadio.txt",
    "features/data/remote_commands/admin_repo_add_tmp_p_lang_git_igorbonadio_igorbonadio.txt",
    "features/data/remote_commands/admin_repo_add_tmp_p_lang_git_igorbonadio_jessicaeto.txt",
    "features/data/remote_commands/admin_repo_add_tmp_p_lang_git_igorbonadio_jessicaeto_igorbonadio.txt",
    "features/data/remote_commands/admin_repo_add_tmp_p_lang_git_igorbonadio_jessicaeto_jessicaeto.txt",
    "features/data/remote_commands/admin_repo_add_tmp_p_lang_git_jessicaeto.txt",
    "features/data/remote_commands/admin_repo_list_igorbonadio.txt",
    "features/data/remote_commands/admin_repo_list_jessicaeto.txt",
    "features/data/remote_commands/admin_repo_read_add_tmp_gritano_git_arybonadio_igorbonadio.txt",
    "features/data/remote_commands/admin_repo_read_add_tmp_gritano_git_arybonadio_jessicaeto.txt",
    "features/data/remote_commands/admin_repo_read_add_tmp_gritano_git_jessicaeto_igorbonadio.txt",
    "features/data/remote_commands/admin_repo_read_add_tmp_gritano_git_jessicaeto_jessicaeto.txt",
    "features/data/remote_commands/admin_repo_read_add_tmp_p_lang_git_jessicaeto_igorbonadio.txt",
    "features/data/remote_commands/admin_repo_read_add_tmp_p_lang_git_jessicaeto_jessicaeto.txt",
    "features/data/remote_commands/admin_repo_read_rm_tmp_jeka_git_aribonadio_igorbonadio.txt",
    "features/data/remote_commands/admin_repo_read_rm_tmp_jeka_git_aribonadio_jessicaeto.txt",
    "features/data/remote_commands/admin_repo_read_rm_tmp_jeka_git_igorbonadio_igorbonadio.txt",
    "features/data/remote_commands/admin_repo_read_rm_tmp_jeka_git_igorbonadio_jessicaeto.txt",
    "features/data/remote_commands/admin_repo_read_rm_tmp_p_lang_git_igorbonadio_igorbonadio.txt",
    "features/data/remote_commands/admin_repo_read_rm_tmp_p_lang_git_igorbonadio_jessicaeto.txt",
    "features/data/remote_commands/admin_repo_rm_tmp_jeka_git_igorbonadio.txt",
    "features/data/remote_commands/admin_repo_rm_tmp_jeka_git_jessicaeto.txt",
    "features/data/remote_commands/admin_repo_rm_tmp_p_lang_git_igorbonadio.txt",
    "features/data/remote_commands/admin_repo_rm_tmp_p_lang_git_jessicaeto.txt",
    "features/data/remote_commands/admin_repo_user_list_tmp_jeka_git_igorbonadio.txt",
    "features/data/remote_commands/admin_repo_user_list_tmp_jeka_git_jessicaeto.txt",
    "features/data/remote_commands/admin_repo_user_list_tmp_ruby_git_igorbonadio.txt",
    "features/data/remote_commands/admin_repo_user_list_tmp_ruby_git_jessicaeto.txt",
    "features/data/remote_commands/admin_repo_write_add_tmp_gritano_git_arybonadio_igorbonadio.txt",
    "features/data/remote_commands/admin_repo_write_add_tmp_gritano_git_arybonadio_jessicaeto.txt",
    "features/data/remote_commands/admin_repo_write_add_tmp_gritano_git_jessicaeto_igorbonadio.txt",
    "features/data/remote_commands/admin_repo_write_add_tmp_gritano_git_jessicaeto_jessicaeto.txt",
    "features/data/remote_commands/admin_repo_write_add_tmp_p_lang_git_jessicaeto_igorbonadio.txt",
    "features/data/remote_commands/admin_repo_write_add_tmp_p_lang_git_jessicaeto_jessicaeto.txt",
    "features/data/remote_commands/admin_repo_write_rm_tmp_gritano_git_arybonadio_igorbonadio.txt",
    "features/data/remote_commands/admin_repo_write_rm_tmp_gritano_git_arybonadio_jessicaeto.txt",
    "features/data/remote_commands/admin_repo_write_rm_tmp_gritano_git_igorbonadio_igorbonadio.txt",
    "features/data/remote_commands/admin_repo_write_rm_tmp_gritano_git_igorbonadio_jessicaeto.txt",
    "features/data/remote_commands/admin_repo_write_rm_tmp_p_lang_git_igorbonadio_igorbonadio.txt",
    "features/data/remote_commands/admin_repo_write_rm_tmp_p_lang_git_igorbonadio_jessicaeto.txt",
    "features/data/remote_commands/admin_user_add_igorbonadio_igorbonadio.txt",
    "features/data/remote_commands/admin_user_add_igorbonadio_jessicaeto.txt",
    "features/data/remote_commands/admin_user_add_jose_igorbonadio.txt",
    "features/data/remote_commands/admin_user_add_jose_jessicaeto.txt",
    "features/data/remote_commands/admin_user_admin_add_arybonadio_igorbonadio.txt",
    "features/data/remote_commands/admin_user_admin_add_arybonadio_jessicaeto.txt",
    "features/data/remote_commands/admin_user_admin_add_igorbonadio_igorbonadio.txt",
    "features/data/remote_commands/admin_user_admin_add_igorbonadio_jessicaeto.txt",
    "features/data/remote_commands/admin_user_admin_rm_arybonadio_igorbonadio.txt",
    "features/data/remote_commands/admin_user_admin_rm_arybonadio_jessicaeto.txt",
    "features/data/remote_commands/admin_user_admin_rm_igorbonadio_igorbonadio.txt",
    "features/data/remote_commands/admin_user_admin_rm_igorbonadio_jessicaeto.txt",
    "features/data/remote_commands/admin_user_email_get_igorbonadio_igorbonadio.txt",
    "features/data/remote_commands/admin_user_email_get_igorbonadio_jessicaeto.txt",
    "features/data/remote_commands/admin_user_email_get_jessicaeto_igorbonadio.txt",
    "features/data/remote_commands/admin_user_email_get_jessicaeto_jessicaeto.txt",
    "features/data/remote_commands/admin_user_email_get_wrong_igorbonadio.txt",
    "features/data/remote_commands/admin_user_email_get_wrong_jessicaeto.txt",
    "features/data/remote_commands/admin_user_email_update_igorbonadio_igor@bonadio_com_igorbonadio.txt",
    "features/data/remote_commands/admin_user_email_update_igorbonadio_igor@bonadio_com_jessicaeto.txt",
    "features/data/remote_commands/admin_user_email_update_wrong_igor@bonadio_com_igorbonadio.txt",
    "features/data/remote_commands/admin_user_email_update_wrong_igor@bonadio_com_jessicaeto.txt",
    "features/data/remote_commands/admin_user_key_add_igorbonadio_marvin_igorbonadio.txt",
    "features/data/remote_commands/admin_user_key_add_igorbonadio_marvin_jessicaeto.txt",
    "features/data/remote_commands/admin_user_key_add_userrr_marvino_igorbonadio.txt",
    "features/data/remote_commands/admin_user_key_add_userrr_marvino_jessicaeto.txt",
    "features/data/remote_commands/admin_user_key_list_arybonadio_igorbonadio.txt",
    "features/data/remote_commands/admin_user_key_list_arybonadio_jessicaeto.txt",
    "features/data/remote_commands/admin_user_key_list_igorbonadio_igorbonadio.txt",
    "features/data/remote_commands/admin_user_key_list_igorbonadio_jessicaeto.txt",
    "features/data/remote_commands/admin_user_key_rm_igorbonadio_eva_igorbonadio.txt",
    "features/data/remote_commands/admin_user_key_rm_igorbonadio_eva_jessicaeto.txt",
    "features/data/remote_commands/admin_user_key_rm_igorbonadio_marvino_igorbonadio.txt",
    "features/data/remote_commands/admin_user_key_rm_igorbonadio_marvino_jessicaeto.txt",
    "features/data/remote_commands/admin_user_list_igorbonadio.txt",
    "features/data/remote_commands/admin_user_list_jessicaeto.txt",
    "features/data/remote_commands/admin_user_repo_list_arybonadio_igorbonadio.txt",
    "features/data/remote_commands/admin_user_repo_list_arybonadio_jessicaeto.txt",
    "features/data/remote_commands/admin_user_repo_list_igorbonadio_igorbonadio.txt",
    "features/data/remote_commands/admin_user_repo_list_igorbonadio_jessicaeto.txt",
    "features/data/remote_commands/admin_user_rm_igorbonadio_igorbonadio.txt",
    "features/data/remote_commands/admin_user_rm_igorbonadio_jessicaeto.txt",
    "features/data/remote_commands/admin_user_rm_jose_igorbonadio.txt",
    "features/data/remote_commands/admin_user_rm_jose_jessicaeto.txt",
    "features/data/remote_commands/admin_version_igorbonadio.txt",
    "features/data/remote_commands/admin_version_jessicaeto.txt",
    "features/data/remote_commands/email_get_igorbonadio.txt",
    "features/data/remote_commands/email_get_jessicaeto.txt",
    "features/data/remote_commands/email_update_email@server_com_igorbonadio.txt",
    "features/data/remote_commands/email_update_email@server_com_jessicaeto.txt",
    "features/data/remote_commands/help_igorbonadio.txt",
    "features/data/remote_commands/help_jessicaeto.txt",
    "features/data/remote_commands/invalid_command_igorbonadio.txt",
    "features/data/remote_commands/invalid_command_jessicaeto.txt",
    "features/data/remote_commands/key_add_keyname_igorbonadio.txt",
    "features/data/remote_commands/key_add_keyname_jessicaeto.txt",
    "features/data/remote_commands/key_list_igorbonadio.txt",
    "features/data/remote_commands/key_list_jessicaeto.txt",
    "features/data/remote_commands/key_rm_hal_igorbonadio.txt",
    "features/data/remote_commands/key_rm_hal_jessicaeto.txt",
    "features/data/remote_commands/repo_list_igorbonadio.txt",
    "features/data/remote_commands/repo_list_jessicaeto.txt",
    "features/data/remote_commands/version_igorbonadio.txt",
    "features/data/remote_commands/version_jessicaeto.txt",
    "features/data/remote_help.txt",
    "features/data/ssh_help.txt",
    "features/install.feature",
    "features/local.feature",
    "features/pub_key.feature",
    "features/remote.feature",
    "features/step_definitions/background_step.rb",
    "features/step_definitions/install_step.rb",
    "features/step_definitions/local_step.rb",
    "features/step_definitions/pub_key_step.rb",
    "features/step_definitions/remote_step.rb",
    "features/support/database_cleaner.rb",
    "features/support/env.rb",
    "gritano.gemspec",
    "lib/gritano.rb",
    "lib/gritano/cli.rb",
    "lib/gritano/config.rb",
    "lib/gritano/console.rb",
    "lib/gritano/console/base.rb",
    "lib/gritano/console/executor.rb",
    "lib/gritano/console/gritano.rb",
    "lib/gritano/console/installer.rb",
    "lib/gritano/console/remote.rb",
    "lib/gritano/models.rb",
    "lib/gritano/models/key.rb",
    "lib/gritano/models/permission.rb",
    "lib/gritano/models/repository.rb",
    "lib/gritano/models/user.rb",
    "lib/gritano/plugin.rb",
    "lib/gritano/plugin/ssh.rb",
    "spec/cli_spec.rb",
    "spec/config_spec.rb",
    "spec/console_base_spec.rb",
    "spec/console_executor_spec.rb",
    "spec/console_gritano_spec.rb",
    "spec/console_installer_spec.rb",
    "spec/console_remote_spec.rb",
    "spec/console_spec.rb",
    "spec/data/help_command_name.txt",
    "spec/model_key_spec.rb",
    "spec/model_permission_spec.rb",
    "spec/model_repository_spec.rb",
    "spec/model_user_spec.rb",
    "spec/plugin_spec.rb",
    "spec/plugin_ssh_spec.rb",
    "spec/spec_helper.rb"
  ]
  s.homepage = "http://igorbonadio.com.br/gritano"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.25"
  s.summary = "Gritano is a tool to configure your git server over ssh"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activerecord>, [">= 3.2.8"])
      s.add_runtime_dependency(%q<sqlite3>, [">= 1.3.6"])
      s.add_runtime_dependency(%q<grit>, [">= 2.5.0"])
      s.add_runtime_dependency(%q<terminal-table>, [">= 1.4.5"])
      s.add_runtime_dependency(%q<sshd_config>, [">= 0"])
      s.add_development_dependency(%q<rspec>, [">= 2.11.0"])
      s.add_development_dependency(%q<rdoc>, [">= 3.12"])
      s.add_development_dependency(%q<cucumber>, [">= 1.2.1"])
      s.add_development_dependency(%q<bundler>, [">= 1.0"])
      s.add_development_dependency(%q<jeweler>, [">= 1.8.4"])
      s.add_development_dependency(%q<simplecov>, [">= 0.6.4"])
      s.add_development_dependency(%q<database_cleaner>, [">= 0.8.0"])
    else
      s.add_dependency(%q<activerecord>, [">= 3.2.8"])
      s.add_dependency(%q<sqlite3>, [">= 1.3.6"])
      s.add_dependency(%q<grit>, [">= 2.5.0"])
      s.add_dependency(%q<terminal-table>, [">= 1.4.5"])
      s.add_dependency(%q<sshd_config>, [">= 0"])
      s.add_dependency(%q<rspec>, [">= 2.11.0"])
      s.add_dependency(%q<rdoc>, [">= 3.12"])
      s.add_dependency(%q<cucumber>, [">= 1.2.1"])
      s.add_dependency(%q<bundler>, [">= 1.0"])
      s.add_dependency(%q<jeweler>, [">= 1.8.4"])
      s.add_dependency(%q<simplecov>, [">= 0.6.4"])
      s.add_dependency(%q<database_cleaner>, [">= 0.8.0"])
    end
  else
    s.add_dependency(%q<activerecord>, [">= 3.2.8"])
    s.add_dependency(%q<sqlite3>, [">= 1.3.6"])
    s.add_dependency(%q<grit>, [">= 2.5.0"])
    s.add_dependency(%q<terminal-table>, [">= 1.4.5"])
    s.add_dependency(%q<sshd_config>, [">= 0"])
    s.add_dependency(%q<rspec>, [">= 2.11.0"])
    s.add_dependency(%q<rdoc>, [">= 3.12"])
    s.add_dependency(%q<cucumber>, [">= 1.2.1"])
    s.add_dependency(%q<bundler>, [">= 1.0"])
    s.add_dependency(%q<jeweler>, [">= 1.8.4"])
    s.add_dependency(%q<simplecov>, [">= 0.6.4"])
    s.add_dependency(%q<database_cleaner>, [">= 0.8.0"])
  end
end

