# frozen_string_literal: true

module NVD
  module JSONFeeds
    module Schema
      #
      # Represents the `"cvssV2"` value.
      #
      class CVSSv2

        # @see https://csrc.nist.gov/schema/nvd/feed/1.1-Beta/cvss-v2.0_beta.json
        VERSIONS = {
          '2.0' => :"2.0"
        }

        # @see https://csrc.nist.gov/schema/nvd/feed/1.1-Beta/cvss-v2.0_beta.json
        ACCESS_VECTORS = {
          'NETWORK' => :NETWORK,
          'ADJACENT_NETWORK' => :ADJACENT_NETWORK,
          'LOCAL' => :LOCAL
        }

        # @see https://csrc.nist.gov/schema/nvd/feed/1.1-Beta/cvss-v2.0_beta.json
        ACCESS_COMPLEXITIES = {
          'HIGH' => :HIGH,
          'MEDIUM' => :MEDIUM,
          'LOW' => :LOW
        }

        # @see https://csrc.nist.gov/schema/nvd/feed/1.1-Beta/cvss-v2.0_beta.json
        AUTHENTICATIONS = {
          'MULTIPLE' => :MULTIPLE,
          'SINGLE'   => :SINGLE,
          'NONE'     => :NONE
        }

        # @see https://csrc.nist.gov/schema/nvd/feed/1.1-Beta/cvss-v2.0_beta.json
        CIAS = {
          'NONE' => :NONE,
          'PARTIAL' => :PARTIAL,
          'COMPLETE' => :COMPLETE
        }

        # @see https://csrc.nist.gov/schema/nvd/feed/1.1-Beta/cvss-v2.0_beta.json
        EXPLOITABILITIES = {
          'UNPROVEN' => :UNPROVEN,
          'PROOF_OF_CONCEPT' => :PROOF_OF_CONCEPT,
          'FUNCTIONAL' => :FUNCTIONAL,
          'HIGH' => :HIGH,
          'NOT_DEFINED' => :NOT_DEFINED
        }

        # @see https://csrc.nist.gov/schema/nvd/feed/1.1-Beta/cvss-v2.0_beta.json
        REMEDIATION_LEVELS = {
          'OFFICIAL_FIX' => :OFFICIAL_FIX,
          'TEMPORARY_FIX' => :TEMPORARY_FIX,
          'WORKAROUND' => :WORKAROUND,
          'UNAVAILABLE' => :UNAVAILABLE,
          'NOT_DEFINED' => :NOT_DEFINED
        }

        # @see https://csrc.nist.gov/schema/nvd/feed/1.1-Beta/cvss-v2.0_beta.json
        REPORT_CONFIDENCES = {
          'UNCONFIRMED' => :UNCONFIRMED,
          'UNCORROBORATED' => :UNCORROBORATED,
          'CONFIRMED' => :CONFIRMED,
          'NOT_DEFINED' => :NOT_DEFINED
        }

        # @see https://csrc.nist.gov/schema/nvd/feed/1.1-Beta/cvss-v2.0_beta.json
        COLLATERAL_DAMAGE_POTENTIALS = {
          'NONE' => :NONE,
          'LOW' => :LOW,
          'LOW_MEDIUM' => :LOW_MEDIUM,
          'MEDIUM_HIGH' => :MEDIUM_HIGH,
          'HIGH' => :HIGH,
          'NOT_DEFINED' => :NOT_DEFINED
        }

        # @see https://csrc.nist.gov/schema/nvd/feed/1.1-Beta/cvss-v2.0_beta.json
        TARGET_DISTRIBUTIONS = {
          "NONE" => :NONE,
          "LOW" => :LOW,
          "MEDIUM" => :MEDIUM,
          "HIGH" => :HIGH,
          "NOT_DEFINED" => :NOT_DEFINED
        }

        # @see https://csrc.nist.gov/schema/nvd/feed/1.1-Beta/cvss-v2.0_beta.json
        CIA_REQUIREMENTS = {
          'LOW'         => :LOW,
          'MEDIUM'      => :MEDIUM,
          'HIGH'        => :HIGH,
          'NOT_DEFINED' => :NOT_DEFINED
        }

        # @return [:"2.0"]
        attr_reader :version

        # @return [String]
        attr_reader :vector_string

        # @return [Float]
        attr_reader :base_score

        # @return [:NETWORK, :ADJACENT_NETWORK, :LOCAL]]
        attr_reader :access_vector

        # @return [:HIGH, :MEDIUM, :LOW]
        attr_reader :access_complexity

        # @return [:MULTIPLE, :SINGLE, :NONE]
        attr_reader :authentication

        # @return [:NONE, :PARTIAL, :COMPLETE]
        attr_reader :confidentiality_impact

        # @return [:NONE, :PARTIAL, :COMPLETE]
        attr_reader :integrity_impact

        # @return [:NONE, :PARTIAL, :COMPLETE]
        attr_reader :availability_impact

        # @return [Float]
        attr_reader :base_score

        # @return [:UNPROVEN, :PROOF_OF_CONCEPT, :FUNCTIONAL, :HIGH, :NOT_DEFINED]
        attr_reader :exploitability

        # @return [:OFFICIAL_FIX, :TEMPORARY_FIX, :WORKAROUND, :UNAVAILABLE, :NOT_DEFINED]
        attr_reader :remediation_level

        # @return [:UNCONFIRMED, :UNCORROBORATED, :CONFIRMED, :NOT_DEFINED]
        attr_reader :report_confidence

        # @return [Float, nil]
        attr_reader :temporal_score

        # @return [:NONE, :LOW, :LOW_MEDIUM, :MEDIUM_HIGH, :HIGH, :NOT_DEFINED]
        attr_reader :collateral_damage_potential

        # @return [:NONE, :LOW, :MEDIUM, :HIGH, :NOT_DEFINED]
        attr_reader :target_distribution

        # @return [:NONE, :PARTIAL, :COMPLETE]
        attr_reader :confidentiality_requirement

        # @return [:NONE, :PARTIAL, :COMPLETE]
        attr_reader :integrity_requirement

        # @return [:NONE, :PARTIAL, :COMPLETE]
        attr_reader :availability_requirement

        # @return [Float, nil]
        attr_reader :environmental_score

        #
        # Initializes the CVSS v2 object.
        #
        def initialize(version: ,
                       vector_string: ,
                       base_score: ,
                       access_vector: nil,
                       access_Complexity: nil,
                       authentication: nil,
                       confidentiality_impact: nil,
                       integrity_impact: nil,
                       availability_impact: nil,
                       exploitability: nil,
                       remediation_level: nil,
                       report_confidence: nil,
                       temporal_score: nil,
                       collateral_damage_potential: nil,
                       target_distribution: nil,
                       confidentiality_requirement: nil,
                       integrity_requirement: nil,
                       availability_requirement: nil,
                       environmental_score: nil)
          @version       = version
          @vector_string = vector_string
          @base_score    = base_score

          @access_vector = access_vector
          @access_Complexity = access_Complexity
          @authentication = authentication
          @confidentiality_impact = confidentiality_impact
          @integrity_impact = integrity_impact
          @availability_impact = availability_impact
          @base_score = base_score
          @exploitability = exploitability
          @remediation_level = remediation_level
          @report_confidence = report_confidence
          @temporal_score = temporal_score
          @collateral_damage_potential = collateral_damage_potential
          @target_distribution = target_distribution
          @confidentiality_requirement = confidentiality_requirement
          @integrity_requirement = integrity_requirement
          @availability_requirement = availability_requirement
          @environmental_score = environmental_score
        end

        #
        # Maps the parsed JSON to a Symbol Hash for {#initialize}.
        #
        # @param [Hash{String => Object}] json
        #   The parsed JSON.
        #
        # @return [Hash{Symbol => Object}]
        #   The Symbol Hash.
        #
        # @see https://csrc.nist.gov/schema/nvd/feed/1.1-Beta/cvss-v2.0_beta.json
        #
        def self.from_json(json)
          {
            version: VERSIONS.fetch(json.fetch('version')),

            vector_string: json.fetch('vectorString'),

            access_vector: if (value = json['accessVector'])
                             ACCESS_VECTORS.fetch(value)
                           end,

            access_Complexity: if (value = json['accessComplexity'])
                                 ACCESS_COMPLEXITIES.fetch(value)
                               end,

            authentication: if (value = json['authentication'])
                              AUTHENTICATIONS.fetch(value)
                            end,

            confidentiality_impact: if (value = json['confidentialityImpact'])
                                      CIAS.fetch(value)
                                    end,

            integrity_impact: if (value = json['integrityImpact'])
                                CIAS.fetch(value)
                              end,

            availability_impact: if (value = json['availabilityImpact'])
                                   CIAS.fetch(value)
                                 end,

            base_score: json.fetch('baseScore'),

            exploitability: if (value = json['exploitability'])
                              EXPLOITABILITIES.fetch(value)
                            end,

            remediation_level: if (value = json['remediationLevel'])
                                 REMEDIATION_LEVELS.fetch(value)
                               end,

            report_confidence: if (value = json['reportConfidence'])
                                 REPORT_CONFIDENCES.fetch(value)
                               end,

            temporal_score: json['temporalScore'],

            collateral_damage_potential: if (value = json['collateralDamagePotential'])
                                           COLLATERAL_DAMAGE_POTENTIALS.fetch(value)
                                         end,

            target_distribution: if (value = json['targetDistribution'])
                                   TARGET_DISTRIBUTIONS.fetch(value)
                                 end,

            confidentiality_requirement: if (value = json['confidentialityRequirement'])
                                           CIA_REQUIREMENTS.fetch(value)
                                         end,

            integrity_requirement: if (value = json['integrityRequirement'])
                                     CIA_REQUIREMENTS.fetch(value)
                                   end,

            availability_requirement: if (value = json['availabilityRequirement'])
                                        CIA_REQUIREMENTS.fetch(value)
                                      end,

            environmental_score: json['environmentalScore']
          }
        end

        #
        # Loads the CVSS v2 object from the parsed JSON.
        #
        # @param [Hash{String => Object}] json
        #   The parsed JSON.
        #
        # @return [CVSSv2]
        #   The CVSSv3 V2 object.
        #
        def self.load(json)
          new(**from_json(json))
        end
      end
    end
  end
end
