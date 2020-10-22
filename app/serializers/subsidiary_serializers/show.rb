class SubsidiarySerializers::Show
  def initialize(subsidiary)
    @subsidiary = subsidiary
  end

  def as_json(_option = nil)
    {
      id: subsidiary.id,
      name: subsidiary.name,
      address: subsidiary.address,
      cnpj: subsidiary.cnpj,
      token: subsidiary.token,
      subsidiary_plans: subsidiary_plans_info(subsidiary)
    }
  end

  private

  attr_reader :subsidiary

  def subsidiary_plans_info(subsidiary)
    subsidiary.subsidiary_plans.available.map do |item|
      {
        id: item.plan.id,
        name: item.plan.name,
        price: item.final_price,
        permanency: "#{item.plan.minimum_period} months"
      }
    end
  end
end
