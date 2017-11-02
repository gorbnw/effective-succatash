module BusinessesHelper
  def tag_counts(testimonials)
    # The following counts the number of tags for the testimonials that are given
    # testimonial_tags = testimonial_tags(testimonials)

    tag_counts = tag_counts_compiler(tags_normalized(testimonials))

    return_tag_count_collection(get_tag_descriptions, tag_counts)
  end
end

private

def return_tag_count_collection(get_tag_descriptions, tag_counts)
  tag_counts_collection = [["Tag", "Count"]]
  get_tag_descriptions.length.times do |i|
    tag_counts_collection << [get_tag_descriptions[i], tag_counts[i]]
  end
  tag_counts_collection
end

def tags_normalized(testimonials)
  find_unique_tags(testimonial_tags(testimonials))
end

def find_unique_tags(all_tags)
  tags_normalized = []
  all_tags.each do |tags|
    tags.each do |tag|
      tags_normalized.push(tag)
    end
  end
  tags_normalized
end

def tag_counts_compiler(tags_normalized)
  tag_counts = []
  Tag.all.each do |tag|
    tag_counts << tags_normalized.count(tag)
  end
  tag_counts
end

def get_tag_descriptions
  Tag.all.map { |tag| tag.description }
end

def testimonial_tags(testimonials)
  testimonials.map do |testimonial|
    testimonial.tags
  end
end
