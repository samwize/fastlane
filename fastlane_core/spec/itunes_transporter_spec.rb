require 'shellwords'
require 'credentials_manager'

describe FastlaneCore do
  describe FastlaneCore::ItunesTransporter do
    describe "avoid_shell_script is true" do
      describe "upload command generation" do
        it 'generates a call to java directly' do
          expected_command = [
            FastlaneCore::Helper.transporter_java_executable_path.shellescape,
            "-Djava.ext.dirs=#{FastlaneCore::Helper.transporter_java_ext_dir.shellescape}",
            '-XX:NewSize=2m',
            '-Xms32m',
            '-Xmx1024m',
            '-Xms1024m',
            '-Djava.awt.headless=true',
            '-Dsun.net.http.retryPost=false',
            "-classpath #{FastlaneCore::Helper.transporter_java_jar_path.shellescape}",
            'com.apple.transporter.Application',
            "-m upload",
            "-u fabric.devtools@gmail.com",
            "-p \\!\\>\\ p@\\$s_-\\+\\=w\\'o\\%rd\\\"\\&\\#\\*\\<",
            "-f /tmp/my.app.id.itmsp",
            "-t Signiant",
            "-k 100000",
            '2>&1'
          ].join(' ')

          transporter = FastlaneCore::ItunesTransporter.new('fabric.devtools@gmail.com', "!> p@$s_-+=w'o%rd\"&#*<", true)
          expect(transporter.upload('my.app.id', '/tmp')).to eq(expected_command)
        end
      end

      describe "download command generation" do
        it 'generates a call to java directly' do
          expected_command = [
            FastlaneCore::Helper.transporter_java_executable_path.shellescape,
            "-Djava.ext.dirs=#{FastlaneCore::Helper.transporter_java_ext_dir.shellescape}",
            '-XX:NewSize=2m',
            '-Xms32m',
            '-Xmx1024m',
            '-Xms1024m',
            '-Djava.awt.headless=true',
            '-Dsun.net.http.retryPost=false',
            "-classpath #{FastlaneCore::Helper.transporter_java_jar_path.shellescape}",
            'com.apple.transporter.Application',
            '-m lookupMetadata',
            '-u fabric.devtools@gmail.com',
            "-p \\!\\>\\ p@\\$s_-\\+\\=w\\'o\\%rd\\\"\\&\\#\\*\\<",
            '-apple_id my.app.id',
            '-destination /tmp',
            '2>&1'
          ].join(' ')

          transporter = FastlaneCore::ItunesTransporter.new('fabric.devtools@gmail.com', "!> p@$s_-+=w'o%rd\"&#*<", true)
          expect(transporter.download('my.app.id', '/tmp')).to eq(expected_command)
        end
      end
    end

    describe "avoid_shell_script is false" do
      describe "upload command generation" do
        it 'generates a call to java directly' do
          expected_command = [
            '"' + FastlaneCore::Helper.transporter_path + '"',
            "-m upload",
            '-u "fabric.devtools@gmail.com"',
            "-p '\\!\\>\\ p@\\$s_-\\+\\=w'\"\\'\"'o\\%rd\\\"\\&\\#\\*\\<'",
            "-f '/tmp/my.app.id.itmsp'",
            nil, # This represents the environment variable which is not set
            "-t 'Signiant'",
            "-k 100000"
          ].join(' ')

          transporter = FastlaneCore::ItunesTransporter.new('fabric.devtools@gmail.com', "!> p@$s_-+=w'o%rd\"&#*<", false)
          expect(transporter.upload('my.app.id', '/tmp')).to eq(expected_command)
        end
      end

      describe "download command generation" do
        it 'generates a call to java directly' do
          expected_command = [
            '"' + FastlaneCore::Helper.transporter_path + '"',
            '-m lookupMetadata',
            '-u "fabric.devtools@gmail.com"',
            "-p '\\!\\>\\ p@\\$s_-\\+\\=w'\"\\'\"'o\\%rd\\\"\\&\\#\\*\\<'",
            "-apple_id my.app.id",
            "-destination '/tmp'"
          ].join(' ')

          transporter = FastlaneCore::ItunesTransporter.new('fabric.devtools@gmail.com', "!> p@$s_-+=w'o%rd\"&#*<", false)
          expect(transporter.download('my.app.id', '/tmp')).to eq(expected_command)
        end
      end
    end
  end
end
