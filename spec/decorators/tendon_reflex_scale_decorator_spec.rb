require 'rails_helper'

RSpec.describe "TendonReflexScaleDecorator", type: :decorator do
  subject { tendon_reflex.decorate }

  let!(:tendon_reflex) do
    create(:tendon_reflex_scale, jaw: "absent",
                                 abdominal: "absent",
                                 right_pectoral: "diminished",
                                 left_pectoral: "moderately_exaggerated",
                                 right_biceps: "normal",
                                 left_biceps: "normal",
                                 right_triceps: "diminished",
                                 left_triceps: "normal",
                                 right_brachioradialis: "diminished",
                                 left_brachioradialis: "absent",
                                 right_pronator: "slightly_exaggerated",
                                 left_pronator: "slightly_exaggerated",
                                 right_patellar_tendon: "absent",
                                 left_patellar_tendon: "markedly_exaggerated",
                                 right_achilles_tendon: "absent",
                                 left_achilles_tendon: "markedly_exaggerated")
  end

  it "show hyperreflexia part" do
    expect(subject.hyperreflexia_part).to eq [
      ["left_pectoral", "moderately_exaggerated"],
      ["right_pronator", "slightly_exaggerated"],
      ["left_pronator", "slightly_exaggerated"],
      ["left_patellar_tendon", "markedly_exaggerated"],
      ["left_achilles_tendon", "markedly_exaggerated"],
    ]
  end

  it "show hyporeflexia part" do
    expect(subject.hyporeflexia_part).to eq [
      ["jaw", "absent"],
      ["abdominal", "absent"],
      ["right_pectoral", "diminished"],
      ["right_triceps", "diminished"],
      ["right_brachioradialis", "diminished"],
      ["left_brachioradialis", "absent"],
      ["right_patellar_tendon", "absent"],
      ["right_achilles_tendon", "absent"],
    ]
  end
end
