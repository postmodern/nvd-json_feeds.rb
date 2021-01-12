# frozen_string_literal: true

module NVD
  module JSONFeeds
    module Schema
      #
      # Represents the `"cvssV3"` value.
      #
      class CVSSv3

        # @see https://csrc.nist.gov/schema/nvd/feed/1.1-Beta/cvss-v3.x_beta.json
        VERSIONS = {
          '3.0' => :"3.0",
          '3.1' => :"3.1"
        }

        # @see https://csrc.nist.gov/schema/nvd/feed/1.1-Beta/cvss-v3.x_beta.json
        ATTACK_VECTORS = {
          'NETWORK'          => :NETWORK,
          'ADJACENT_NETWORK' => :ADJACENT_NETWORK,
          'LOCAL'            => :LOCAL,
          'PHYSICAL'         => :PHYSICAL
        }

        # @see https://csrc.nist.gov/schema/nvd/feed/1.1-Beta/cvss-v3.x_beta.json
        MODIFIED_ATTACK_VECTORS = ATTACK_VECTORS.merge(
          'NOT_DEFINED' => :NOT_DEFINED
        )

        # @see https://csrc.nist.gov/schema/nvd/feed/1.1-Beta/cvss-v3.x_beta.json
        ATTACK_COMPLEXITIES = {
          'HIGH' => :HIGH,
          'LOW'  => :LOW
        }

        # @see https://csrc.nist.gov/schema/nvd/feed/1.1-Beta/cvss-v3.x_beta.json
        MODIFIED_ATTACK_COMPLEXITIES = MODIFIED_ATTACK_VECTORS.merge(
          'NOT_DEFINED' => :NOT_DEFINED
        )

        # @see https://csrc.nist.gov/schema/nvd/feed/1.1-Beta/cvss-v3.x_beta.json
        PRIVILEGES_REQUIRED = {
          'HIGH' => :HIGH,
          'LOW'  => :LOW,
          'NONE' => :NONE
        }

        # @see https://csrc.nist.gov/schema/nvd/feed/1.1-Beta/cvss-v3.x_beta.json
        MODIFIED_PRIVILEGES_REQUIRED = PRIVILEGES_REQUIRED.merge(
          'NOT_DEFINED' => :NOT_DEFINED
        )

        # @see https://csrc.nist.gov/schema/nvd/feed/1.1-Beta/cvss-v3.x_beta.json
        USER_INTERACTIONS = {
          'NONE'     => :NONE,
          'REQUIRED' => :REQUIRED
        }

        # @see https://csrc.nist.gov/schema/nvd/feed/1.1-Beta/cvss-v3.x_beta.json
        MODIFIED_USER_INTERACTIONS = USER_INTERACTIONS.merge(
          'NOT_DEFINED' => :NOT_DEFINED
        )

        # @see https://csrc.nist.gov/schema/nvd/feed/1.1-Beta/cvss-v3.x_beta.json
        SCOPES = {
          'UNCHANGED' => :UNCHANGED,
          'CHANGED'   => :CHANGED
        }

        # @see https://csrc.nist.gov/schema/nvd/feed/1.1-Beta/cvss-v3.x_beta.json
        MODIFIED_SCOPES = SCOPES.merge(
          'NOT_DEFINED' => :NOT_DEFINED
        )

        # @see https://csrc.nist.gov/schema/nvd/feed/1.1-Beta/cvss-v3.x_beta.json
        CIAS = {
          'NONE' => :NONE,
          'LOW'  => :LOW,
          'HIGH' => :HIGH
        }

        # @see https://csrc.nist.gov/schema/nvd/feed/1.1-Beta/cvss-v3.x_beta.json
        MODIFIED_CIAS = CIAS.merge(
          'NOT_DEFINED' => :NOT_DEFINED
        )

        # @see https://csrc.nist.gov/schema/nvd/feed/1.1-Beta/cvss-v3.x_beta.json
        EXPLOIT_CODE_MATURITIES = {
          'UNPROVEN' => :UNPROVEN,
          'PROOF_OF_CONCEPT' => :PROOF_OF_CONCEPT,
          'FUNCTIONAL' => :FUNCTIONAL,
          'HIGH' => :HIGH,
          'NOT_DEFINED' => :NOT_DEFINED
        }

        # @see https://csrc.nist.gov/schema/nvd/feed/1.1-Beta/cvss-v3.x_beta.json
        REMEDIATION_LEVELS = {
          'OFFICIAL_FIX' => :OFFICIAL_FIX,
          'TEMPORARY_FIX' => :TEMPORARY_FIX,
          'WORKAROUND' => :WORKAROUND,
          'UNAVAILABLE' => :UNAVAILABLE,
          'NOT_DEFINED' => :NOT_DEFINED
        }

        # @see https://csrc.nist.gov/schema/nvd/feed/1.1-Beta/cvss-v3.x_beta.json
        CONFIDENCES = {
          'UNKNOWN' => :UNKNOWN,
          'REASONABLE' => :REASONABLE,
          'CONFIRMED' => :CONFIRMED,
          'NOT_DEFINED' => :NOT_DEFINED
        }

        # @see https://csrc.nist.gov/schema/nvd/feed/1.1-Beta/cvss-v3.x_beta.json
        CIA_REQUIREMENTS = {
          'LOW' => :LOW,
          'MEDIUM' => :MEDIUM,
          'HIGH' => :HIGH,
          'NOT_DEFINED' => :NOT_DEFINED
        }

        # @see https://csrc.nist.gov/schema/nvd/feed/1.1-Beta/cvss-v3.x_beta.json
        SEVERITIES = {
          'NONE' => :NONE,
          'LOW' => :LOW,
          'MEDIUM' => :MEDIUM,
          'HIGH' => :HIGH,
          'CRITICAL' => :CRITICAL
        }

        #
        # Initializes the CVSS v3 object.
        #
        def initialize(version: ,
                       vector_string: ,
                       base_score: ,
                       base_severity: ,
                       attack_vector: nil,
                       attack_complexity: nil,
                       privileges_required: nil,
                       user_interaction: nil,
                       scope: nil,
                       confidentiality_impact: nil,
                       integrity_impact: nil,
                       availability_impact: nil,
                       exploit_code_maturity: nil,
                       remediation_level: nil,
                       report_confidence: nil,
                       temporal_score: nil,
                       temporal_severity: nil,
                       confidentiality_requirement: nil,
                       integrity_requirement: nil,
                       availability_requirement: nil,
                       modified_attack_vector: nil,
                       modified_attack_complexity: nil,
                       modified_privileges_required: nil,
                       modified_user_interaction: nil,
                       modified_scope: nil,
                       modified_confidentiality_impact: nil,
                       modified_integrity_impact: nil,
                       modified_availability_impact: nil,
                       environmental_score: nil,
                       environmental_severity: nil)
          @version = version
          @vector_string = vector_string
          @base_score = base_score
          @base_severity = base_severity

          @attack_vector = attack_vector
          @attack_complexity = attack_complexity
          @privileges_required = privileges_required
          @user_interaction = user_interaction
          @scope = scope
          @confidentiality_impact = confidentiality_impact
          @integrity_impact = integrity_impact
          @availability_impact = availability_impact
          @exploit_code_maturity = exploit_code_maturity
          @remediation_level = remediation_level
          @report_confidence = report_confidence
          @temporal_score = temporal_score
          @temporal_severity = temporal_severity
          @confidentiality_requirement = confidentiality_requirement
          @integrity_requirement = integrity_requirement
          @availability_requirement = availability_requirement
          @modified_attack_vector = modified_attack_vector
          @modified_attack_complexity = modified_attack_complexity
          @modified_privileges_required = modified_privileges_required
          @modified_user_interaction = modified_user_interaction
          @modified_scope = modified_scope
          @modified_confidentiality_impact = modified_confidentiality_impact
          @modified_integrity_impact = modified_integrity_impact
          @modified_availability_impact = modified_availability_impact
          @environmental_score = environmental_score
          @environmental_severity = environmental_severity
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
        # @see https://csrc.nist.gov/schema/nvd/feed/1.1-Beta/cvss-v3.x_beta.json
        #
        def self.from_json(json)
          {
            version: VERSIONS.fetch(json.fetch('version')),
            vector_string: json.fetch('vectorString'),

            attack_vector: if (value = json['attackVector'])
                             ATTACK_VECTORS.fetch(value)
                           end,

            attack_complexity: if (value = json['attackComplexity'])
                                 ATTACK_COMPLEXITIES.fetch(value)
                               end,

            privileges_required: if (value = json['privilegesRequired'])
                                   PRIVILEGES_REQUIRED.fetch(value)
                                 end,

            user_interaction: if (value = json['userInteraction'])
                                USER_INTERACTIONS.fetch(value)
                              end,

            scope: if (value = json['scope'])
                     SCOPES.fetch(value)
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

            base_score: json['baseScore'],
            base_severity: if (value = json['baseSeverity'])
                             SEVERITIES.fetch(value)
                           end,

            exploit_code_maturity: if (value = json['exploitCodeMaturity'])
                                     EXPLOIT_CODE_MATURITIES.fetch(value)
                                   end,

            remediation_level: if (value = json['remediationLevel'])
                                 REMEDIATION_LEVELS.fetch(value)
                               end,

            report_confidence: if (value = json['reportConfidence'])
                                 CONFIDENCES.fetch(value)
                               end,

            temporal_score: json['temporalScore'],

            temporal_severity: if (value = json['temporalSeverity'])
                                 SEVERITIES.fetch(value)
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

            modified_attack_vector: if (value = json['modifiedAttackVector'])
                                      MODIFIED_ATTACK_VECTORS.fetch(value)
                                    end,

            modified_attack_complexity: if (value = json['modifiedAttackComplexity'])
                                          MODIFIED_ATTACK_COMPLEXITIES.fetch(value)
                                        end,

            modified_privileges_required: if (value = json['modifiedPrivilegesRequired'])
                                            MODIFIED_PRIVILEGES_REQUIRED.fetch(value)
                                          end,

            modified_user_interaction: if (value = json['modifiedUserInteraction'])
                                         MODIFIED_USER_INTERACTIONS.fetch(value)
                                       end,

            modified_scope: if (value = json['modifiedScope'])
                              SCOPES.fetch(value)
                            end,

            modified_confidentiality_impact: if (value = json['modifiedConfidentialityImpact'])
                                               MODIFIED_CIA.fetch(value)
                                             end,

            modified_integrity_impact: if (value = json['modifiedIntegrityImpact'])
                                         MODIFIED_CIA.fetch(value)
                                       end,

            modified_availability_impact: if (value = json['modifiedAvailabilityImpact'])
                                            MODIFIED_CIA.fetch(value)
                                          end,

            environmental_score:    json['environmentalScore'],
            environmental_severity: json['environmentalSeverity']
          }
        end

        #
        # Loads the CVSS v3 object from the parsed JSON.
        #
        # @param [Hash{String => Object}] json
        #   The parsed JSON.
        #
        # @return [CVSSv3]
        #   The CVSSv3 V3 object.
        #
        def self.load(json)
          new(**from_json(json))
        end

      end
    end
  end
end
