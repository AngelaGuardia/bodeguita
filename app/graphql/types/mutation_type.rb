module Types
  class MutationType < Types::BaseObject
    field :update_image, mutation: Mutations::Images::UpdateImage
  end
end
