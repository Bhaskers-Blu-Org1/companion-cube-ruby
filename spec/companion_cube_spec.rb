require "spec_helper"

CC_URL = "https://cc.example.com".freeze

RSpec.describe CompanionCube do # rubocop:disable Metrics/BlockLength
  it "has a version number" do
    expect(CompanionCube::VERSION).not_to be nil
  end

  context "constructor" do
    it "fails if required parameters are missing" do
      expect { CompanionCube::Client.new }.to raise_error(StandardError)
    end

    it "optionally accepts access and secret keys" do
      expect do
        CompanionCube::Client.new(
          url:        "http://example.com",
          access_key: "access",
          secret_key: "secret"
        )
      end.not_to raise_error # best practice is #not_to raise_error without specific error
    end
  end

  context do # rubocop:disable Metrics/BlockLength
    before(:all) do
      @cc = CompanionCube::Client.new(url: CC_URL)
    end

    context "courses" do
      before(:each) do
        stub_request(:get, "#{CC_URL}/courses")
          .to_return(status: 200, body: '[{ "id": "1" }]')
      end

      it "sends a request to retrieve courses" do
        expect(@cc.courses.first["id"]).to eq("1")
      end
    end

    context "create_course" do
      before(:each) do
        stub_request(:post, "#{CC_URL}/courses")
          .to_return(status: 201, body: "1")
      end

      it "sends a request to create a course" do
        course = @cc.create_course(
          run:          "RUN1",
          archive_file: StringIO.new("fake")
        )
        expect(course).to eq("1")
      end
    end

    context "delete_course" do
      before(:each) do
        stub_request(:post, "#{CC_URL}/courses")
          .to_return(status: 201, body: "0")
      end

      it "sends a request to delete a course" do
        course = @cc.delete_course()
        expect(course).to eq("0")
      end
    end

    context "course" do
      before(:each) do
        stub_request(:get, "#{CC_URL}/courses/1")
          .to_return(status: 200, body: '{ "id": "1" }')
      end

      it "sends a request to retrieve the specified course" do
        expect(@cc.course(1)["id"]).to eq("1")
      end
    end

    context "update_course" do
      before(:each) do
        stub_request(:put, "#{CC_URL}/courses/1")
          .to_return(status: 200, body: "1")
      end

      it "sends a request to update the specified course" do
        course = @cc.update_course(1, archive_file: StringIO.new("fake"))
        expect(course).to eq("1")
      end
    end

    def hash_to_url(hash)
      hash.map do |key_pair|
        key_pair.map { |el| URI.escape(el.to_s, "+ &=") }.join("=")
      end.join("&")
    end

    context "report" do
      report_params = {
        start_date: "2017-05-11T22:56:19Z",
        end_date:   "2017-05-11T22:56:19Z",
        course_id:  "course-v1:BigDataUniversity+BD0101EN+course",
        format:     "csv"
      }

      before(:each) do
        stub_request(:get, "#{CC_URL}/reports/completions?#{hash_to_url(report_params)}")
          .to_return(status: 200, body: '{ "id": "1" }')
      end

      it "sends a request to retrieve the specified course" do
        response = @cc.reports("completions", report_params)
        expect(response).not_to be_empty
        # TODO
        # expect(response.code.to_s).to eq("200")
        # expect(response.headers.fetch(:content_type).to eq("text/csv"))
      end
    end
  end
end
