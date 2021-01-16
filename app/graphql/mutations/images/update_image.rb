class Mutations::Images::UpdateImage < Mutations::BaseMutation
  argument :id, ID, required: true
  argument :name, String, required: false
  argument :description, String, required: false
  argument :price, Float, required: false
  argument :url, String, required: false
  argument :inventory, Integer, required: false

  type Types::ImageType

  def resolve(attributes)
    image = Image.find(attributes[:id])
    image.update(attributes)
    image
  end
end
